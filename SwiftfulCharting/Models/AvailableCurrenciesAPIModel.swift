//
//  AvailableCurrenciesAPIModel.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 19/05/2022.
//

import Foundation

struct AvailableCurrenciesModel {
    var currency: String
}

extension AvailableCurrenciesModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case currency = "currencies"
    }
}
