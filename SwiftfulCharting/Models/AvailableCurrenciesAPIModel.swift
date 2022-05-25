//
//  AvailableCurrenciesAPIModel.swift
//  SwiftfulCharting
//
//  Created by Łukasz Janiszewski on 19/05/2022.
//

import Foundation

struct AvailableCurrenciesModel: Decodable {
    /*
     SAMPLE RESPONSE:
     
     {
        "currencies":{
            "AED":"United Arab Emirates dirham"
            "AFN":"Afghan afghani"
            "ALL":"Albanian lek"
            (...)
            "ZWL":"Zimbabwean dollar"
        }
        "status":"success"
     }
     
     */
    
    let currencies: [String: String]
}

extension AvailableCurrenciesModel {
    enum CodingKeys: String, CodingKey {
        case currencies
    }
}


