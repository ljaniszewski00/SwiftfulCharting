//
//  ChartViewModel.swift
//  SwiftfulCharting
//
//  Created by Users on 19/05/2022.
//

import Foundation
import SwiftUI
import SwiftUICharts

class ChartViewModel: ObservableObject {
    @Published var startingDate: Date = Date()
    @Published var endingDate: Date = Date()
    @Published var fromCurrency: String = "EUR"
    @Published var amount: String = "1.0"
    @Published var toCurrency: String = "USD"
    
    @Published var availableCurrencies = [String]()
    @Published var historicalCurrencyData = ([String](), [Double]())
    
    @Published var showInfoView: Bool = false
    @Published var showContentViewColorSheet: Bool = false
    @Published var showSettingsView: Bool = false
    @Published var showProgressIndicator: Bool = false
    @Published var showChartView: Bool = false
    @Published var dataReadyToGenerateChart: Bool = false
    @Published var showChartViewSettingsView: Bool = false
    @Published var showContentView: Bool = false
    
    var oldStartingDate: Date = Date()
    private let dayDurationInSeconds: TimeInterval = 60*60*24
    
    var chartData: ChartData {
        return ChartData(values: Array(zip(historicalCurrencyData.0, historicalCurrencyData.1)))
    }
    
    init() {
        fetchAvailableCurrenciesData() {}
    }
    
    func fetchAvailableCurrenciesData(completion: @escaping (() -> ())) {
        DispatchQueue.main.async {
            APIManager.shared.getAvailableCurrencies { availableCurrenciesModel in
                self.availableCurrencies = DataManager.shared.getAvailableCurrencies(availableCurrenciesModel: availableCurrenciesModel)
                self.fromCurrency = self.availableCurrencies[0]
                self.toCurrency = self.availableCurrencies[1]
                completion()
            }
        }
    }
    
    func fetchHistoricalCurrencyData(completion: @escaping (() -> ())) {
        let g = DispatchGroup()
        var historicalCurrencyDataTemp = [HistoricalCurrencyDataModel]()
        for date in stride(from: self.startingDate, to: self.endingDate, by: self.dayDurationInSeconds) {
            print(date)
        }
        for date in stride(from: self.startingDate, to: self.endingDate, by: self.dayDurationInSeconds) {
            g.enter()
                APIManager.shared.getHistoricalCurrencyData(date: convertDateToStringDate(date: date), fromCurrency: String(self.fromCurrency.prefix(3)), amount: self.amount.replacingOccurrences(of: ",", with: "."), toCurrency: String(self.toCurrency.prefix(3))) {
                    historicalCurrencyDataModel in
                    historicalCurrencyDataTemp.append(historicalCurrencyDataModel)
                    sleep(2)
                    g.leave()
                }
        }
        g.notify(queue:.main) {
            self.historicalCurrencyData = DataManager.shared.getHistoricalCurrencyData(historicalCurrencyDataModels: historicalCurrencyDataTemp)
            print(self.historicalCurrencyData)
            completion()
        }
    }
    
    func filterDataByNewDates() {
        var historicalCurrencyDataDates = historicalCurrencyData.0
        var historicalCurrencyDataValues = historicalCurrencyData.1
        var indexedToBeDeleted = [Int]()
        for (index, date) in historicalCurrencyDataDates.enumerated() {
            if date < convertDateToStringDate(date: self.startingDate) || date > convertDateToStringDate(date: self.endingDate) {
                indexedToBeDeleted.append(index)
            }
        }
        indexedToBeDeleted = indexedToBeDeleted.sorted(by: >)
        for index in indexedToBeDeleted {
            historicalCurrencyDataDates.remove(at: index)
            historicalCurrencyDataValues.remove(at: index)
        }
        historicalCurrencyData = (historicalCurrencyDataDates, historicalCurrencyDataValues)
    }
    
}
