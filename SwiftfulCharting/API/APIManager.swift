//
//  APIManager.swift
//  SwiftfulCharting
//
//  Created by Łukasz Janiszewski on 25/05/2022.
//

import Foundation

class APIManager {
    private let headers = [
        "X-RapidAPI-Host": "fixer-fixer-currency-v1.p.rapidapi.com",
        "X-RapidAPI-Key": "API_KEY"
    ]
    
    enum APICallTypes {
        case supportedSymbols
        case latestRates
        case historicalRates
        case convert
    }
    
    static var shared: APIManager {
        APIManager()
    }
    
    private init() {}
    
    private func buildRequestFor(_ apiCallType: APICallTypes, base: String = "USD", symbols: [String] = ["GBP", "JPY", "EUR"], date: String = "2013-12-24", convertTo: String = "GBP", amount: String = "1.0") -> NSMutableURLRequest {
        let request: NSMutableURLRequest
        
        let newBase = String(base.prefix(3))
        let newConvertTo = String(convertTo.prefix(3))
        let newAmount = amount.replacingOccurrences(of: ",", with: ".")
        
        var newSymbols = [String]()
        for symbol in symbols {
            newSymbols.append(String(symbol.prefix(3)))
        }
        
        var symbolsForURLRequest: String = ""
        for symbol in newSymbols {
            symbolsForURLRequest += symbol
            if symbol != symbols.last {
                symbolsForURLRequest += "%2C"
            }
        }
        
        switch apiCallType {
        case .supportedSymbols:
            request = NSMutableURLRequest(url: NSURL(string: "https://fixer-fixer-currency-v1.p.rapidapi.com/symbols")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        case .latestRates:
            request = NSMutableURLRequest(url: NSURL(string: "https://fixer-fixer-currency-v1.p.rapidapi.com/latest?base=\(newBase)&symbols=\(symbolsForURLRequest)")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
        case .historicalRates:
            request = NSMutableURLRequest(url: NSURL(string: "https://fixer-fixer-currency-v1.p.rapidapi.com/\(date)?base=\(newBase)&symbols=\(symbolsForURLRequest)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
            
        case .convert:
            request = NSMutableURLRequest(url: NSURL(string: "https://fixer-fixer-currency-v1.p.rapidapi.com/convert?from=\(newBase)&to=\(newConvertTo)&amount=\(newAmount)&date=\(date)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
        }
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
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
    
    func getSupportedSymbols(completion: @escaping ((SupportedSymbolsModel) -> ())) {
        let request = buildRequestFor(.supportedSymbols)
        makeAPICall(request: request) { supportedSymbolsData in
            do {
                let decodedSupportedSymbols = try JSONDecoder().decode(SupportedSymbolsModel.self, from: supportedSymbolsData)
                completion(decodedSupportedSymbols)
            } catch {
                print("JSONDecoder error:", error)
            }
        }
    }
    
    func getLatestRates(base: String = "USD", symbols: [String] = ["GBP", "JPY", "EUR"], completion: @escaping ((LatestRatesModel) -> ())) {
        let request = buildRequestFor(.latestRates, base: base, symbols: symbols)
        makeAPICall(request: request) { latestRatesData in
            do {
                let decodedLatestRates = try JSONDecoder().decode(LatestRatesModel.self, from: latestRatesData)
                completion(decodedLatestRates)
            } catch {
                print("JSONDecoder error:", error)
            }
        }
    }
    
    func getHistoricalRates(base: String = "USD", symbols: [String] = ["GBP", "JPY", "EUR"], date: String = "2013-12-24", completion: @escaping ((HistoricalRatesModel) -> ())) {
        let request = buildRequestFor(.historicalRates, base: base, symbols: symbols, date: date)
        makeAPICall(request: request) { historicalRatesData in
            do {
                let decodedHistoricalRates = try JSONDecoder().decode(HistoricalRatesModel.self, from: historicalRatesData)
                completion(decodedHistoricalRates)
            } catch {
                print("JSONDecoder error:", error)
            }
        }
    }
    
    func getConvert(base: String = "USD", convertTo: String = "GBP", amount: String = "1.0", date: String = "2013-12-24", completion: @escaping ((ConvertModel) -> ())) {
        let request = buildRequestFor(.convert, base: base, date: date, convertTo: convertTo, amount: amount)
        makeAPICall(request: request) { convertData in
            do {
                let decodedConvert = try JSONDecoder().decode(ConvertModel.self, from: convertData)
                completion(decodedConvert)
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
