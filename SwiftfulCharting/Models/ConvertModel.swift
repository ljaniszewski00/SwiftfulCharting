//
//  ConvertModel.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 30/05/2022.
//

import Foundation

struct ConvertModel: Decodable, Hashable, Equatable {
    /*
     SAMPLE RESPONSE:
     
     {
         "success":true
         "query":{
             "from":"USD"
             "to":"ILS"
             "amount":12
         }
         "info":{
             "timestamp":1544654047
             "rate":3.74915
         }
         "date":"2018-12-12"
         "result":44.9898
     }
     
     */
    
    var query: Query
    var info: Info
    var date: String
    var result: Double
    
    enum CodingKeys: String, CodingKey {
        case query
        case info
        case date
        case result
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
    
    static func ==(lhs: ConvertModel, rhs: ConvertModel) -> Bool {
        return lhs.date == rhs.date
    }
    
    struct Query: Decodable {
        var from: String
        var to: String
        var amount: Double
        
        enum CodingKeys: String, CodingKey {
            case from
            case to
            case amount
        }
    }
    
    struct Info: Decodable {
        var rate: Double
        
        enum CodingKeys: String, CodingKey {
            case rate
        }
    }
}
