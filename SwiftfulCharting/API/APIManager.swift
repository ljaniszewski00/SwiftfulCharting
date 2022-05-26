//
//  APIManager.swift
//  SwiftfulCharting
//
//  Created by Łukasz Janiszewski on 25/05/2022.
//

import Foundation

class APIManager {
    private let headers: [String: String]
    
    enum APICallTypes {
        case availableCurrencies
        case historicalCurrencyData
    }
    
    static var shared: APIManager {
        APIManager()
    }
    
    private init() {
        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
            headers = [
                "X-RapidAPI-Host": "currency-converter5.p.rapidapi.com",
                "X-RapidAPI-Key": apiKey
            ]
        } else {
            headers = [
                "X-RapidAPI-Host": "currency-converter5.p.rapidapi.com",
                "X-RapidAPI-Key": "NO-KEY"
            ]
        }
    }
    
    private func buildRequestFor(_ apiCallType: APICallTypes, date: String = "2020-01-20", fromCurrency: String = "EUR", amount: String = "1.0", toCurrency: String = "GBP") -> NSMutableURLRequest {
        let request: NSMutableURLRequest
        
        switch apiCallType {
        case .availableCurrencies:
            request = NSMutableURLRequest(url: NSURL(string: "https://currency-converter5.p.rapidapi.com/currency/list?format=json")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        case .historicalCurrencyData:
            request = NSMutableURLRequest(url: NSURL(string: "https://currency-converter5.p.rapidapi.com/currency/historical/\(date)?from=\(fromCurrency)&amount=\(amount)&format=json&to=\(toCurrency)")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        }
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    private func makeAPICall(request: NSMutableURLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
        
        print(response)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Fatal error")
        }
        
        return data
    }
    
    func getAvailableCurrencies() async throws -> AvailableCurrenciesModel {
        let request = buildRequestFor(.availableCurrencies)
        let availableCurrenciesData = try await makeAPICall(request: request)
        let result = try JSONDecoder().decode(AvailableCurrenciesModel.self, from: availableCurrenciesData)
        return result
    }
    
    func getHistoricalCurrencyData(date: String = "2020-01-20", fromCurrency: String = "EUR", amount: String = "1.0", toCurrency: String = "GBP") async throws -> HistoricalCurrencyDataModel {
        let request = buildRequestFor(.historicalCurrencyData, date: date, fromCurrency: fromCurrency, amount: amount, toCurrency: toCurrency)
        let historicalCurrencyData = try await makeAPICall(request: request)
        let result = try JSONDecoder().decode(HistoricalCurrencyDataModel.self, from: historicalCurrencyData)
        print(result)
        return result
    }
}

extension APIManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
