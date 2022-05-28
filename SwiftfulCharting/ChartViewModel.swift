//
//  ChartViewModel.swift
//  SwiftfulCharting
//
//  Created by Users on 19/05/2022.
//

import Foundation
import SwiftUI

class ChartViewModel: ObservableObject {
    @Published var startingDate: Date = Date()
    @Published var endingDate: Date = Date()
    @Published var fromCurrency: String = "EUR"
    @Published var amount: String = "1.0"
    @Published var toCurrency: String = "USD"
    
    @Published var availableCurrencies = [String]()
    @Published var historicalCurrencyData = [HistoricalCurrencyDataModel]()
    
    @Published var showInfoView: Bool = false
    @Published var showSettingsView: Bool = false
    @Published var showChartViewSettingsSheet: Bool = false
    @Published var showChartView: Bool = false
    @Published var showContentView: Bool = false
    
    var historicalCurrencyChartData: [String: Double] {
        DataManager.shared.getHistoricalCurrencyData(historicalCurrencyDataModels: historicalCurrencyData)
    }
    
    func getDateFrom(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date)!
    }
    
    func convertDateToStringDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func fetchAvailableCurrenciesData() async {
        DispatchQueue.main.async { [weak self] in
            Task.init {
                self?.availableCurrencies = DataManager.shared.getAvailableCurrencies(availableCurrenciesModel: try await APIManager.shared.getAvailableCurrencies())
            }
        }
    }
    
    func fetchHistoricalCurrencyData() async {
        DispatchQueue.main.async { [weak self] in
            Task.init {
                let dayDurationInSeconds: TimeInterval = 60*60*24
                var n = 0
                for date in stride(from: self!.startingDate, to: self!.endingDate, by: dayDurationInSeconds) {
//                    self?.historicalCurrencyData.append(try await APIManager.shared.getHistoricalCurrencyData(date: self!.convertDateToStringDate(date: date), fromCurrency: self!.fromCurrency, amount: self!.amount, toCurrency: self!.toCurrency))
                    print(n)
                    try await Task.sleep(nanoseconds: 1_000_000_000)
                    n += 1
                    
                }
                
            }
        }
    }
    
}
