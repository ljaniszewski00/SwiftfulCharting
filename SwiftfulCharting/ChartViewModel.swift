//
//  ChartViewModel.swift
//  SwiftfulCharting
//
//  Created by Users on 19/05/2022.
//

import Foundation

class ChartViewModel: ObservableObject {
    @Published var date: Date = Date()
    @Published var fromCurrency: String = "EUR"
    @Published var amount: Double = 1.0
    @Published var toCurrency: String = "USD"
    
    @Published var availableCurrencies = [String: String]()
    @Published var historicalCurrencyData: HistoricalCurrencyDataModel? = nil
    
    var stringDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func fetchAvailableCurrenciesData() async {
        Task.init {
            availableCurrencies = try await APIManager.shared.getAvailableCurrencies().currencies
        }
    }
    
    func fetchHistoricalCurrencyData() async {
        Task.init {
            historicalCurrencyData = try await APIManager.shared.getHistoricalCurrencyData(date: stringDate, fromCurrency: fromCurrency, amount: amount, toCurrency: toCurrency)
        }
    }
    
}
