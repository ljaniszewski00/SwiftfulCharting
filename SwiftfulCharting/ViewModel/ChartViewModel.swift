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
    @Published var base: String = "USD"
    @Published var amount: String = "1.0"
    @Published var symbols: [String] = []
    @Published var convertTo: String = "GBP"
    
    @Published var supportedSymbols = [String]()
    @Published var latestRatesModel: LatestRatesModel? = nil
    @Published var historicalRatesModel: HistoricalRatesModel? = nil
    @Published var convertModels: [ConvertModel]? = nil
    
    // ContentView
    @Published var showInfoView: Bool = false
    @Published var showContentViewColorSheet: Bool = false
    @Published var showChooseCallView: Bool = false
    
    // ChooseCallView
    @Published var showAdjustDataView: Bool = false
    
    // AdjustViews
    @Published var showSymbolsList: Bool = false
    @Published var showProgressIndicator: Bool = false
    @Published var showChartView: Bool = false
    
    // ChartView
    @Published var showChartViewSettingsView: Bool = false
    @Published var showContentView: Bool = false
    
    @Published var searchText: String = ""
    
    var searchResults: [String] {
        if !searchText.isEmpty {
            return supportedSymbols.filter { $0.contains(searchText) }
        } else {
            return supportedSymbols
        }
    }
    
    enum APICallTypesForUser {
        case latestRates
        case historicalRates
        case convert
    }
    
    var apiCallType: APICallTypesForUser = .convert
    
    let apiCallNames: [String] = [
        "Latest Rates",
        "Historical Rates",
        "Convert"
    ]
    
    let apiCallTypes: [String: String] = [
        "Latest Rates": "The API's latest endpoint will return real-time exchange rate data updated every 60 minutes.",
        "Historical Rates": "Historical rates are available for most currencies all the way back to the year of 1999.",
        "Convert": "Convert any amount from one currency to another."
    ]
    
    var oldStartingDate: Date = Date()
    private let dayDurationInSeconds: TimeInterval = 60*60*24
    
    init() {
        fetchSupportedSymbols() {}
    }
    
    func fetchSupportedSymbols(completion: @escaping (() -> ())) {
        APIManager.shared.getSupportedSymbols { supportedSymbolsModel in
            DispatchQueue.main.async {
                self.supportedSymbols = DataManager.shared.getSupportedSymbols(supportedSymbolsModel: supportedSymbolsModel)
                self.base = self.supportedSymbols[0]
                self.symbols = [self.supportedSymbols[1]]
                completion()
            }
        }
    }
    
    func fetchLatestRates(completion: @escaping (() -> ())) {
        APIManager.shared.getLatestRates(base: base, symbols: symbols) { latestRatesModel in
            DispatchQueue.main.async {
                self.latestRatesModel = latestRatesModel
            }
        }
    }
    
    func fetchHistoricalRates(completion: @escaping (() -> ())) {
        APIManager.shared.getHistoricalRates(base: base, symbols: symbols, date: convertDateToStringDate(date: startingDate)) { historicalRatesModel in
            DispatchQueue.main.async {
                self.historicalRatesModel = historicalRatesModel
            }
        }
    }
    
    func fetchConvert(completion: @escaping (() -> ())) {
        let g = DispatchGroup()
        var convertModels = [ConvertModel]()
        for date in stride(from: self.startingDate, to: self.endingDate, by: self.dayDurationInSeconds) {
            g.enter()
            APIManager.shared.getConvert(base: base, convertTo: convertTo, amount: amount, date: convertDateToStringDate(date: date)) { convertModel in
                convertModels.append(convertModel)
                g.leave()
            }
        }
        g.notify(queue: .main) {
            self.convertModels = convertModels
            completion()
        }
    }
    
    func filterDataByNewDates() {
        if let convertModels = convertModels {
            var indexedToBeDeleted = [Int]()
            for (index, convertModel) in convertModels.enumerated() {
                if convertModel.date < convertDateToStringDate(date: startingDate) || convertModel.date > convertDateToStringDate(date: self.endingDate) {
                    indexedToBeDeleted.append(index)
                }
            }
            indexedToBeDeleted = indexedToBeDeleted.sorted(by: >)
            for index in indexedToBeDeleted {
                self.convertModels!.remove(at: index)
            }
        }
    }
    
}
