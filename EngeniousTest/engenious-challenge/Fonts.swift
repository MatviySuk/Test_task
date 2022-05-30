//
//  Fonts.swift
//  engenious-challenge
//
//  Created by Matviy Suk on 29.05.2022.
//

import Foundation
import UIKit

enum SfProText {
    case medium
    case semibold
    case bold
    
    func of(size: CGFloat) -> UIFont {
        switch self {
        case .medium:
            return UIFont(name: "SF Pro Text Medium", size: size) ?? .systemFont(ofSize: size, weight: .medium)
        case .semibold:
            return UIFont(name: "SFProDisplay-Semibold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
        case .bold:
            return UIFont(name: "SF Pro Text Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
        }
    }
}
