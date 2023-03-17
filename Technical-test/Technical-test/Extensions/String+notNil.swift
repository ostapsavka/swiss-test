//
//  String+notNil.swift
//  Technical-test
//
//  Created by Ostap Savka on 16.03.2023.
//

import Foundation

extension Optional where Wrapped == String {
    var notNil: String {
        switch self {
        case .none:
            return ""
        case .some(let text):
            return text
        }
    }
}
