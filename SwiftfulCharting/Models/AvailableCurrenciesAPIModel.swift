//
//  AvailableCurrenciesAPIModel.swift
//  SwiftfulCharting
//
//  Created by Łukasz Janiszewski on 19/05/2022.
//

import Foundation

struct AvailableCurrenciesModel: Decodable {
    let currencies: [Currency]
    
    struct Currency: Codable {
        let eur, aed, afn, all, zmw, zwl, usd: String

        enum CodingKeys: String, CodingKey {
            case eur = "EUR"
            case aed = "AED"
            case afn = "AFN"
            case all = "ALL"
            case zmw = "ZMW"
            case zwl = "ZWL"
            case usd = "USD"
        }
    }
}


