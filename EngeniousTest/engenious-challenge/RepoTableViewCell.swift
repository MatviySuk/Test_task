//
//  RepoTableViewCell.swift
//  engenious-challenge
//
//  Created by Abdullah Atkaev on 20.05.2022.
//

import UIKit
import SnapKit

class RepoTableViewCell: UITableViewCell {
    
    // MARK: - Views
    private(set) lazy var containerView = UIView()

    private(set) lazy var titleLabel = UILabel().apply {
        $0.numberOfLines = .zero
    }
    
    private(set) lazy var descLabel = UILabel().apply {
        $0.numberOfLines = .zero
    }
    
    private(set) lazy var dataStack = UIStackView().apply {
        $0.spacing = 8
        $0.axis = .vertical
    }

    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        containerView.applyGradient(colours: [ColorPalette.pattensBlue60, ColorPalette.frenchPass])
        containerView.cornerRadius = 10
    }
    
    // MARK: - Layout
    
    private func layout() {
        self.contentView.addSubview(containerView)
        
        [
            dataStack
        ].forEach { view in
            containerView.addSubview(view)
        }
        
        [
            titleLabel,
            descLabel
        ].forEach { view in
            self.dataStack.addArrangedSubview(view)
        }
        
        containerView.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview().inset(8)
            maker.leading.trailing.equalToSuperview().inset(20.5)
        }
        
        dataStack.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(16)
        }
    }
}

fileprivate extension UIView {
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]? = nil) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}
