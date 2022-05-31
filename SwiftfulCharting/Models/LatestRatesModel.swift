//
//  LatestRatesModel.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 30/05/2022.
//

import Foundation

struct LatestRatesModel: Decodable {
    /*
     SAMPLE RESPONSE:
     
     {
         "success":true
         "timestamp":1544654047
         "base":"EUR"
         "date":"2018-12-12"
         "rates":{
             "GBP":0.900289
             "JPY":128.811562
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
