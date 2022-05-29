//
//  DataManager.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 26/05/2022.
//

import Foundation

class DataManager {
    static var shared: DataManager {
        DataManager()
    }
    
    private init() {}
    
    func getAvailableCurrencies(availableCurrenciesModel: AvailableCurrenciesModel) -> [String] {
        var availableCurrencies = [String]()
        for availableCurrency in availableCurrenciesModel.currencies {
            availableCurrencies.append(availableCurrency.key + " - " + availableCurrency.value)
        }
        return availableCurrencies.sorted()
    }
    
    func getHistoricalCurrencyData(historicalCurrencyDataModels: [HistoricalCurrencyDataModel]) -> [String: Double] {
        var historicalCurrencyDataDictionary = [String: Double]()
        for historicalCurrencyDataModel in historicalCurrencyDataModels {
            historicalCurrencyDataDictionary[historicalCurrencyDataModel.updatedDate] = Double(historicalCurrencyDataModel.rates.currency!.rateForAmount)
        }
        return [String: Double](uniqueKeysWithValues: historicalCurrencyDataDictionary.sorted { $0.key < $1.key })
    }
}

extension DataManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
