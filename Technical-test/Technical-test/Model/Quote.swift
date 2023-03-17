//
//  Quote.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation

struct Quote: Codable {
    var symbol: String?
    var name: String?
    var currency: String?
    var readableLastChangePercent: String?
    var last: String?
    var variationColor: VariationColor?
    var myMarket: Market?
}
