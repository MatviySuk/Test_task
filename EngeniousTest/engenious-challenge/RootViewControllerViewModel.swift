//
//  RootViewControllerViewModel.swift
//  engenious-challenge
//
//  Created by Matviy Suk on 29.05.2022.
//

import Foundation


final class RootViewControllerViewModel {
    // MARK: - Callbacks
    var didUpdateRepos: (() -> Void)?
    
    // MARK: - Services
    private var repoService = RepositoryService()
    
    
    // MARK: - Content
    @Published private(set) var repoList: [Repo] = []

    func updateReposBy(_ user: String) {
        repoService.getAllReposOf(user) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let repos):
                DispatchQueue.main.async {
                    // Combine
                    self.repoList = repos
                    
                    // Non 
                    self.didUpdateRepos?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
