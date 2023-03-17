//
//  VariationColor.swift
//  Technical-test
//
//  Created by Ostap Savka on 16.03.2023.
//

import UIKit

enum VariationColor: String, Codable {
    case green = "green"
    case red = "red"
    
    var color: UIColor {
        switch self {
        case .green:
            return .green
        case .red:
            return .red
        }
    }
}
