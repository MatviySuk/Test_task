//
//  Applyable.swift
//  engenious-challenge
//
//  Created by Matviy Suk on 29.05.2022.
//

import Foundation

protocol Applyable { }

extension Applyable {

    // MARK: - Appearance

    @discardableResult
    func apply(_ configuration: (Self) throws -> Void) rethrows -> Self {
        try configuration(self)

        return self
    }
}

extension NSObject: Applyable { }
