//
//  HistoricalCurrencyDataModel.swift
//  SwiftfulCharting
//
//  Created by Łukasz Janiszewski on 19/05/2022.
//

import Foundation

struct HistoricalCurrencyDataModel: Decodable {
    /*
     SAMPLE RESPONSE:
     
     {
        "amount":"1.0000"
        "base_currency_code":"EUR"
        "base_currency_name":"Euro"
        "rates":{
            "GBP":{
                "currency_name":"Pound sterling"
                "rate":"0.8541"
                "rate_for_amount":"0.8541"
        }
     }
        "status":"success"
        "updated_date":"2020-01-20"
     
     */
    
    var amount: String
    var baseCurrencyCode: String
    var baseCurrencyName: String
    var rates: Rates
    var status: String
    var updatedDate: String
    
    enum CodingKeys: String, CodingKey {
        case amount
        case baseCurrencyCode = "base_currency_code"
        case baseCurrencyName = "base_currency_name"
        case rates
        case status
        case updatedDate = "updated_date"
    }
    
    struct Rates: Decodable {
        var currency: Currency?
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            for key in container.allKeys {
                currency = try? container.decode(Currency.self, forKey: key)
            }
        }
        
        struct CodingKeys: CodingKey {
            var stringValue: String
            init?(stringValue: String) {
                self.stringValue = stringValue
            }
            var intValue: Int?
            init?(intValue: Int) {
                return nil
            }
        }
        
        struct Currency: Decodable {
            let currencyName: String
            let rate: String
            let rateForAmount: String
            
            enum CodingKeys: String, CodingKey {
                case currencyName = "currency_name"
                case rate
                case rateForAmount = "rate_for_amount"
            }
        }
    }
}
