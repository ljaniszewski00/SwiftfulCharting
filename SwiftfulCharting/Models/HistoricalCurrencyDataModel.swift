//
//  HistoricalCurrencyDataModel.swift
//  SwiftfulCharting
//
//  Created by Łukasz Janiszewski on 19/05/2022.
//

import Foundation

struct HistoricalCurrencyDataModel: Decodable {
    var amount: String
    var baseCurrencyCode: String
    var baseCurrencyName: String
    var rates: String
    var status: String
    var updatedDate: String
}
