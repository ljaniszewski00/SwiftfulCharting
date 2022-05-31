//
//  HistoricalRatesModel.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 30/05/2022.
//

import Foundation

struct HistoricalRatesModel: Decodable {
    /*
     SAMPLE RESPONSE:
     
     {
         "success":true
         "timestamp":1387929599
         "historical":true
         "base":"EUR"
         "date":"2013-12-24"
         "rates":{
             "USD":1.367761
             "CAD":1.453867
             "EUR":1
         }
     }
     
     */
    
    var base: String
    var date: String
    var rates: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case base
        case date
        case rates
    }
}
