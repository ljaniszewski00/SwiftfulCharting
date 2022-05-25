//
//  ChartViewModel.swift
//  SwiftfulCharting
//
//  Created by Users on 19/05/2022.
//

import Foundation

class ChartViewModel: ObservableObject {
    @Published var fromCurrency: String = "EUR"
    @Published var amount: Double = 1.0
    @Published var toCurrency: String = "USD"
    var currencies: [String] = ["PLN", "USD", "CAD", "SOT"]
    
    @Published var availableCurrencies: AvailableCurrenciesModel? = nil
    @Published var historicalCurrencyData: HistoricalCurrencyDataModel? = nil
    
    func fetchAvailableCurrenciesData() async {
        Task.init {
            availableCurrencies = try await APIManager.shared.getAvailableCurrencies()
        }
    }
    
    func fetchHistoricalCurrencyData() async {
        Task.init {
            historicalCurrencyData = try await APIManager.shared.getHistoricalCurrencyData(fromCurrency: fromCurrency, amount: amount, toCurrency: toCurrency)
        }
    }
    
}
