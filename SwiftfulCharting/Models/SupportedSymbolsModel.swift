//
//  SupportedSymbolsModel.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 30/05/2022.
//

import Foundation

struct SupportedSymbolsModel: Decodable {
    /*
     SAMPLE RESPONSE:
     
     {
         "success":true
         "symbols":{
             "AED":"United Arab Emirates Dirham"
             "AFN":"Afghan Afghani"
             "ALL":"Albanian Lek"
             "AMD":"Armenian Dram"
             (...)
             "ZMW":"Zambian Kwacha"
             "ZWL":"Zimbabwean Dollar"
         }
     }
     
     */
    
    let symbols: [String: String]
}

extension SupportedSymbolsModel {
    enum CodingKeys: String, CodingKey {
        case symbols
    }
}
