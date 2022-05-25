//
//  APIManager.swift
//  SwiftfulCharting
//
//  Created by Łukasz Janiszewski on 25/05/2022.
//

import Foundation

class APIManager {
    private let headers = [
        "X-RapidAPI-Host": "currency-converter5.p.rapidapi.com",
        "X-RapidAPI-Key": "8d3c69b775mshcc24b34f5cf077dp1dea3bjsn71f7afa7ced8"
    ]
    
    enum APICallTypes {
        case availableCurrencies
        case historicalCurrencyData
    }
    
    static var shared: APIManager {
        APIManager()
    }
    
    private init() {}
    
    private func buildRequestFor(_ apiCallType: APICallTypes, fromCurrency: String = "EUR", amount: Double = 1.0, toCurrency: String = "GBP") -> NSMutableURLRequest {
        let request: NSMutableURLRequest
        
        switch apiCallType {
        case .availableCurrencies:
            request = NSMutableURLRequest(url: NSURL(string: "https://currency-converter5.p.rapidapi.com/currency/list")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        case .historicalCurrencyData:
            request = NSMutableURLRequest(url: NSURL(string: "https://currency-converter5.p.rapidapi.com/currency/historical/2020-01-20?from=\(fromCurrency)&amount=\(amount)&format=json&to=\(toCurrency)")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        }
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    private func makeAPICall(request: NSMutableURLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
        
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//            fatalError("Fatal error")
//        }
        
        return data
    }
    
    func getAvailableCurrencies() async throws -> AvailableCurrenciesModel {
        let request = buildRequestFor(.availableCurrencies)
        let availableCurrenciesData = try await makeAPICall(request: request)
        print("AVAILABLE CURRENCIES DATA", availableCurrenciesData)
        let result = try JSONDecoder().decode(AvailableCurrenciesModel.self, from: availableCurrenciesData)
        print("DECODING AVAILABLE CURRENCY RESULT", result)
        return result
    }
    
    func getHistoricalCurrencyData(fromCurrency: String, amount: Double, toCurrency: String) async throws -> HistoricalCurrencyDataModel {
        let request = buildRequestFor(.historicalCurrencyData, fromCurrency: fromCurrency, amount: amount, toCurrency: toCurrency)
        let historicalCurrencyData = try await makeAPICall(request: request)
        print("HISTORICAL CURRENCY DATA", historicalCurrencyData)
        let result = try JSONDecoder().decode(HistoricalCurrencyDataModel.self, from: historicalCurrencyData)
        print("DECODING HISTORICAL CURRENCY RESULT", result)
        return result
    }
}

extension APIManager: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
