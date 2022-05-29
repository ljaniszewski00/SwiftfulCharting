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
        "X-RapidAPI-Key": "b323b5381amsh8abf895d7669b45p13d16bjsn93ff7a67de3e"
    ]
    
    enum APICallTypes {
        case availableCurrencies
        case historicalCurrencyData
    }
    
    static var shared: APIManager {
        APIManager()
    }
    
    private init() {
//        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
//            headers = [
//                "X-RapidAPI-Host": "currency-converter5.p.rapidapi.com",
//                "X-RapidAPI-Key": "b323b5381amsh8abf895d7669b45p13d16bjsn93ff7a67de3e"
//            ]
//        } else {
//            headers = [
//                "X-RapidAPI-Host": "currency-converter5.p.rapidapi.com",
//                "X-RapidAPI-Key": "b323b5381amsh8abf895d7669b45p13d16bjsn93ff7a67de3e"
//            ]
//        }
    }
    
    private func buildRequestFor(_ apiCallType: APICallTypes, date: String = "2020-01-20", fromCurrency: String = "EUR", amount: String = "1.0", toCurrency: String = "GBP") -> NSMutableURLRequest {
        let request: NSMutableURLRequest
        
        switch apiCallType {
        case .availableCurrencies:
            request = NSMutableURLRequest(url: URL(string: "https://currency-converter5.p.rapidapi.com/currency/list?format=json")!,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        case .historicalCurrencyData:
            request = NSMutableURLRequest(url: URL(string: "https://currency-converter5.p.rapidapi.com/currency/historical/\(date)?from=\(fromCurrency)&amount=\(amount)&format=json&to=\(toCurrency)")!,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        }
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
//    private func makeAPICall(request: NSMutableURLRequest) async throws -> Data {
//        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
//
//        print(response)
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//            fatalError("Fatal error")
//        }
//
//        return data
//    }
    
    private func makeAPICall(request: NSMutableURLRequest, completion: @escaping ((Data) -> ())) {
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            print(response)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Fatal error")
            }
            if let data = data {
                completion(data)
            }
        }
        .resume()
    }
    
    func getAvailableCurrencies(completion: @escaping ((AvailableCurrenciesModel) -> ())) {
        let request = buildRequestFor(.availableCurrencies)
        makeAPICall(request: request) { availableCurrenciesData in
            do {
                let decodedAvailableCurrencies = try JSONDecoder().decode(AvailableCurrenciesModel.self, from: availableCurrenciesData)
                completion(decodedAvailableCurrencies)
            } catch {
                print("JSONDecoder error:", error)
            }
        }
    }
    
    func getHistoricalCurrencyData(date: String = "2020-01-20", fromCurrency: String = "EUR", amount: String = "1.0", toCurrency: String = "GBP", completion: @escaping ((HistoricalCurrencyDataModel) -> ())) {
        let request = buildRequestFor(.historicalCurrencyData, date: date, fromCurrency: fromCurrency, amount: amount, toCurrency: toCurrency)
        makeAPICall(request: request) { historicalCurrencyData in
            do {
                let decodedHistoricalCurrencyData = try JSONDecoder().decode(HistoricalCurrencyDataModel.self, from: historicalCurrencyData)
                completion(decodedHistoricalCurrencyData)
            } catch {
                print("JSONDecoder error:", error)
            }
            
        }
    }
}

extension APIManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
