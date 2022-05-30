//
//  StringAttributes.swift
//  engenious-challenge
//
//  Created by Matviy Suk on 29.05.2022.
//

import UIKit

struct StringAttributes {
    static let nameLabelAttr: [NSAttributedString.Key : Any] = {
        [
            .font : SfProText.bold.of(size: 24),
            .kern : 0.37,
            .foregroundColor : ColorPalette.tealBlue
        ]
    }()
    
    static let repoLabelAttr: [NSAttributedString.Key : Any] = {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.01
        
        return [
            .font : SfProText.semibold.of(size: 20),
            .kern : 0.38,
            .foregroundColor : ColorPalette.scienceBlue,
            .paragraphStyle : style
        ]
    }()
    
    static let tableCellTitleAttr: [NSAttributedString.Key : Any] = {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.02
        
        return [
            .font : SfProText.bold.of(size: 18),
            .kern : -0.41,
            .foregroundColor : ColorPalette.scienceBlue,
            .paragraphStyle : style
        ]
    }()
    
    static let tableCellDescAttr: [NSAttributedString.Key : Any] = {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 0.96
        
        return [
            .font : SfProText.medium.of(size: 14),
            .foregroundColor : ColorPalette.regalBlue,
            .paragraphStyle : style
        ]
    }()
}
