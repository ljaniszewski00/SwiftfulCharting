//
//  CurrencyConverterAPIModel.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 19/05/2022.
//

import Foundation

struct CurrencyConverterModel {
    var amount: String
    var baseCurrencyCode: String
    var baseCurrencyName: String
    var rates: [String: String]
    var status: String
    var updatedDate: String
}

extension CurrencyConverterModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case baseCurrencyCode = "base_currency_code"
        case baseCurrencyName = "base_currency_name"
        case rates: "rates"
        case status: "status"
        case updatedDate: "updated_date"
    }
}
