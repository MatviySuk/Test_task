//
//  ViewController.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import Combine

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: Constants
    private let heightCoef = UIScreen.main.bounds.height / 812
    private let widthCoef = UIScreen.main.bounds.width / 375
    private let username: String = "Apple"
    
    // MARK: - Views
    private(set) lazy var nameLabel = UILabel().apply {
        $0.attributedText = NSAttributedString(
            string: username,
            attributes: StringAttributes.nameLabelAttr
        )
    }
    
    private(set) lazy var repoLabel = UILabel().apply {
        $0.attributedText = NSAttributedString(
            string: "Repositories",
            attributes: StringAttributes.repoLabelAttr
        )
    }
    
    private(set) lazy var tableView = UITableView().apply {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - ViewModel
    private var viewModel = RootViewControllerViewModel()
    
    // MARK: - Subscripts
    private var subscriptions = Set<AnyCancellable>()

    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        configure()
        configureViewModel()
    }
    
    // MARK: - Configuration
    
    private func configure() {
        layout()
    }
    
    private func configureViewModel() {
        // MARK: - Non-Combine
//        viewModel.didUpdateRepos = { [weak self] in
//            self?.tableView.reloadData()
//        }
        
        // MARK: - Combine
        viewModel.$repoList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
            self?.tableView.reloadData()
        }.store(in: &subscriptions)
                
        viewModel.updateReposBy(username)
    }
    
    
    // MARK: - Layout
    
    private func layout() {
        [
            nameLabel,
            repoLabel,
            tableView
        ].forEach { view in
            self.view.addSubview(view)
        }
        
        nameLabel.snp.makeConstraints { maker in
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(26 * heightCoef)
            maker.leading.trailing.equalToSuperview().inset(20.5 * widthCoef)
        }
        
        repoLabel.snp.makeConstraints { maker in
            maker.top.equalTo(nameLabel.snp.bottom).offset(32 * heightCoef)
            maker.leading.trailing.equalToSuperview().inset(20.5 * widthCoef)
        }
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(repoLabel.snp.bottom).offset(16 * heightCoef)
            maker.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repoList.count
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: RepoTableViewCell.self)
        ) as? RepoTableViewCell else {
            return .init()
        }
        
        let repo = viewModel.repoList[indexPath.row]
        cell.titleLabel.attributedText = NSAttributedString(
            string: repo.name,
            attributes: StringAttributes.tableCellTitleAttr
        )
        cell.descLabel.attributedText = NSAttributedString(
            string: repo.description ?? " ",
            attributes: StringAttributes.tableCellDescAttr
        )
        
        return cell
    }
}
