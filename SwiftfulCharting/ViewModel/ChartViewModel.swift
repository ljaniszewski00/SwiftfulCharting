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
    @Published var base: String = "EUR"
    @Published var amount: String = "1.0"
    @Published var convertTo: String = "JPY"
    
    @Published var symbols: [String] = ["AED - United Arab Emirates Dirham", "AFN - Afghan Afghani", "ALL - Albanian Lek", "AMD - Armenian Dram", "ANG - Netherlands Antillean Guilder"]
    
    @Published var supportedSymbols = ["AED - United Arab Emirates Dirham", "AFN - Afghan Afghani", "ALL - Albanian Lek", "AMD - Armenian Dram", "ANG - Netherlands Antillean Guilder", "AOA - Angolan Kwanza", "ARS - Argentine Peso", "AUD - Australian Dollar", "AWG - Aruban Florin", "AZN - Azerbaijani Manat", "BAM - Bosnia-Herzegovina Convertible Mark", "BBD - Barbadian Dollar", "BDT - Bangladeshi Taka", "BGN - Bulgarian Lev", "BHD - Bahraini Dinar", "BIF - Burundian Franc", "BMD - Bermudan Dollar", "BND - Brunei Dollar", "BOB - Bolivian Boliviano", "BRL - Brazilian Real", "BSD - Bahamian Dollar", "BTC - Bitcoin", "BTN - Bhutanese Ngultrum", "BWP - Botswanan Pula", "BYN - New Belarusian Ruble", "BYR - Belarusian Ruble", "BZD - Belize Dollar", "CAD - Canadian Dollar", "CDF - Congolese Franc", "CHF - Swiss Franc", "CLF - Chilean Unit of Account (UF)", "CLP - Chilean Peso", "CNY - Chinese Yuan", "COP - Colombian Peso", "CRC - Costa Rican Colón", "CUC - Cuban Convertible Peso", "CUP - Cuban Peso", "CVE - Cape Verdean Escudo", "CZK - Czech Republic Koruna", "DJF - Djiboutian Franc", "DKK - Danish Krone", "DOP - Dominican Peso", "DZD - Algerian Dinar", "EGP - Egyptian Pound", "ERN - Eritrean Nakfa", "ETB - Ethiopian Birr", "EUR - Euro", "FJD - Fijian Dollar", "FKP - Falkland Islands Pound", "GBP - British Pound Sterling", "GEL - Georgian Lari", "GGP - Guernsey Pound", "GHS - Ghanaian Cedi", "GIP - Gibraltar Pound", "GMD - Gambian Dalasi", "GNF - Guinean Franc", "GTQ - Guatemalan Quetzal", "GYD - Guyanaese Dollar", "HKD - Hong Kong Dollar", "HNL - Honduran Lempira", "HRK - Croatian Kuna", "HTG - Haitian Gourde", "HUF - Hungarian Forint", "IDR - Indonesian Rupiah", "ILS - Israeli New Sheqel", "IMP - Manx pound", "INR - Indian Rupee", "IQD - Iraqi Dinar", "IRR - Iranian Rial", "ISK - Icelandic Króna", "JEP - Jersey Pound", "JMD - Jamaican Dollar", "JOD - Jordanian Dinar", "JPY - Japanese Yen", "KES - Kenyan Shilling", "KGS - Kyrgystani Som", "KHR - Cambodian Riel", "KMF - Comorian Franc", "KPW - North Korean Won", "KRW - South Korean Won", "KWD - Kuwaiti Dinar", "KYD - Cayman Islands Dollar", "KZT - Kazakhstani Tenge", "LAK - Laotian Kip", "LBP - Lebanese Pound", "LKR - Sri Lankan Rupee", "LRD - Liberian Dollar", "LSL - Lesotho Loti", "LTL - Lithuanian Litas", "LVL - Latvian Lats", "LYD - Libyan Dinar", "MAD - Moroccan Dirham", "MDL - Moldovan Leu", "MGA - Malagasy Ariary", "MKD - Macedonian Denar", "MMK - Myanma Kyat", "MNT - Mongolian Tugrik", "MOP - Macanese Pataca", "MRO - Mauritanian Ouguiya", "MUR - Mauritian Rupee", "MVR - Maldivian Rufiyaa", "MWK - Malawian Kwacha", "MXN - Mexican Peso", "MYR - Malaysian Ringgit", "MZN - Mozambican Metical", "NAD - Namibian Dollar", "NGN - Nigerian Naira", "NIO - Nicaraguan Córdoba", "NOK - Norwegian Krone", "NPR - Nepalese Rupee", "NZD - New Zealand Dollar", "OMR - Omani Rial", "PAB - Panamanian Balboa", "PEN - Peruvian Nuevo Sol", "PGK - Papua New Guinean Kina", "PHP - Philippine Peso", "PKR - Pakistani Rupee", "PLN - Polish Zloty", "PYG - Paraguayan Guarani", "QAR - Qatari Rial", "RON - Romanian Leu", "RSD - Serbian Dinar", "RUB - Russian Ruble", "RWF - Rwandan Franc", "SAR - Saudi Riyal", "SBD - Solomon Islands Dollar", "SCR - Seychellois Rupee", "SDG - Sudanese Pound", "SEK - Swedish Krona", "SGD - Singapore Dollar", "SHP - Saint Helena Pound", "SLL - Sierra Leonean Leone", "SOS - Somali Shilling", "SRD - Surinamese Dollar", "STD - São Tomé and Príncipe Dobra", "SVC - Salvadoran Colón", "SYP - Syrian Pound", "SZL - Swazi Lilangeni", "THB - Thai Baht", "TJS - Tajikistani Somoni", "TMT - Turkmenistani Manat", "TND - Tunisian Dinar", "TOP - Tongan Paʻanga", "TRY - Turkish Lira", "TTD - Trinidad and Tobago Dollar", "TWD - New Taiwan Dollar", "TZS - Tanzanian Shilling", "UAH - Ukrainian Hryvnia", "UGX - Ugandan Shilling", "USD - United States Dollar", "UYU - Uruguayan Peso", "UZS - Uzbekistan Som", "VEF - Venezuelan Bolívar Fuerte", "VND - Vietnamese Dong", "VUV - Vanuatu Vatu", "WST - Samoan Tala", "XAF - CFA Franc BEAC", "XAG - Silver (troy ounce)", "XAU - Gold (troy ounce)", "XCD - East Caribbean Dollar", "XDR - Special Drawing Rights", "XOF - CFA Franc BCEAO", "XPF - CFP Franc", "YER - Yemeni Rial", "ZAR - South African Rand", "ZMK - Zambian Kwacha (pre-2013)", "ZMW - Zambian Kwacha", "ZWL - Zimbabwean Dollar"]
    
    @Published var latestRatesModel: LatestRatesModel? = LatestRatesModel(base: "EUR", date: "2020-05-14", rates: ["AED": 3.67, "AFN": 89.50, "ALL": 113.05, "AMD": 445.64, "ANG": 1.80])
    @Published var historicalRatesModel: HistoricalRatesModel? = HistoricalRatesModel(base: "EUR", date: "2022-05-24", rates: ["AED": 3.67, "AFN": 89.50, "ALL": 113.05, "AMD": 445.64, "ANG": 1.80])
    @Published var convertModels: [ConvertModel]? = [ConvertModel(query: ConvertModel.Query(from: "EUR", to: "JPY", amount: 25), info: ConvertModel.Info(rate: 138.654), date: "2022-05-24", result: 3466.35), ConvertModel(query: ConvertModel.Query(from: "EUR", to: "JPY", amount: 25), info: ConvertModel.Info(rate: 150.0), date: "2022-05-25", result: 3750.0), ConvertModel(query: ConvertModel.Query(from: "EUR", to: "JPY", amount: 25), info: ConvertModel.Info(rate: 130.0), date: "2022-05-26", result: 3250)]
    
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
    
    @Published var barChartData: BarChartData? = nil
    @Published var lineChartData: LineChartData? = nil
    
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
            DispatchQueue.main.async { [self] in
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
                completion()
            }
        }
    }
    
    func fetchHistoricalRates(completion: @escaping (() -> ())) {
        APIManager.shared.getHistoricalRates(base: base, symbols: symbols, date: convertDateToStringDate(date: startingDate)) { historicalRatesModel in
            DispatchQueue.main.async {
                self.historicalRatesModel = historicalRatesModel
                completion()
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
    
    func prepareLatestRatesAndHistoricalRatesChartData() {
        var data = BarDataSet(
            dataPoints: [BarChartDataPoint]())

        if apiCallType == .latestRates {
            for key in Array(latestRatesModel!.rates.keys) {
                data.dataPoints.append(BarChartDataPoint(value: latestRatesModel!.rates[key]!, xAxisLabel: key))
            }
        } else {
            for key in Array(historicalRatesModel!.rates.keys) {
                data.dataPoints.append(BarChartDataPoint(value: historicalRatesModel!.rates[key]!, xAxisLabel: key))
            }
        }
        
        let gridStyle  = GridStyle(
            numberOfLines: apiCallType == .latestRates ? latestRatesModel!.rates.count : historicalRatesModel!.rates.count,
            lineColour: Color(.lightGray).opacity(0.5)
        )
        
        let barStyle = BarStyle(
            barWidth: 0.8,
            cornerRadius: CornerRadius(topLeft: 10,
                                       topRight: 10,
                                       bottomLeft: 10,
                                       bottomRight: 10),
            colour: ColourStyle(colour: .accentColor))
        
        let barChartStyle = BarChartStyle(
            infoBoxPlacement: .infoBox(isStatic: false),
            infoBoxValueColour: Color.primary,
            infoBoxBorderStyle: StrokeStyle(lineWidth: 1),
            xAxisGridStyle: gridStyle,
            xAxisLabelPosition: .bottom,
            xAxisLabelColour: .accentColor,
            xAxisLabelsFrom: .chartData(rotation: Angle(degrees: 0)),
            xAxisTitle: "Currency",
            xAxisTitleFont: Font(CTFont(.system, size: 15)).bold(),
            yAxisGridStyle: gridStyle,
            yAxisLabelPosition: .leading,
            yAxisLabelColour: .accentColor,
            yAxisNumberOfLabels: apiCallType == .latestRates ? latestRatesModel!.rates.count : historicalRatesModel!.rates.count,
            yAxisTitle: "Values",
            yAxisTitleFont: Font(CTFont(.system, size: 15)).bold(),
            baseline: .minimumValue,
            topLine: .maximumValue,
            globalAnimation: .easeOut(duration: 2))

        var yAxisLabels = [String]()
        if apiCallType == .latestRates {
            for value in Array(latestRatesModel!.rates.values) {
                yAxisLabels.append(String(value))
            }
        } else {
            for value in Array(historicalRatesModel!.rates.values) {
                yAxisLabels.append(String(value))
            }
        }
        
        barChartData = BarChartData(
            dataSets: data,
            xAxisLabels: apiCallType == .latestRates ? Array(latestRatesModel!.rates.keys) : Array(historicalRatesModel!.rates.keys),
            yAxisLabels: yAxisLabels,
            barStyle: barStyle,
            chartStyle: barChartStyle)
    }
    
    func prepareConvertChartData() {
        var data = LineDataSet(
            dataPoints: [LineChartDataPoint](),
            legendTitle: "value",
            pointStyle: PointStyle(),
            style: LineStyle(lineColour: ColourStyle(colour: .accentColor),
                             lineType: .curvedLine)
        )

        var xAxisLabels = [String]()
        for convertModel in convertModels! {
            data.dataPoints.append(LineChartDataPoint(value: convertModel.result, xAxisLabel: convertModel.date, description: convertModel.date))
            xAxisLabels.append(convertModel.date)
        }
        
        let gridStyle  = GridStyle(
            numberOfLines: convertModels!.count + 3,
            lineColour: Color(.lightGray).opacity(0.5)
        )
        
        let chartStyle = LineChartStyle(
            infoBoxPlacement: .infoBox(isStatic: false),
            infoBoxBorderColour: Color.primary,
            infoBoxBorderStyle: StrokeStyle(lineWidth: 1),
            xAxisGridStyle: gridStyle,
            xAxisLabelPosition: .bottom,
            xAxisLabelColour: .accentColor,
            xAxisLabelsFrom: .chartData(rotation: Angle(degrees: 0)),
            xAxisTitle: "Days",
            xAxisTitleFont: Font(CTFont(.system, size: 15)).bold(),
            yAxisGridStyle: gridStyle,
            yAxisLabelPosition: .leading,
            yAxisLabelColour: .accentColor,
            yAxisNumberOfLabels: convertModels!.count + 3,
            yAxisTitle: "Values",
            yAxisTitleFont: Font(CTFont(.system, size: 15)).bold(),
            baseline: .minimumValue,
            topLine: .maximumValue,
            globalAnimation: .easeOut(duration: 2)
        )
        
        lineChartData = LineChartData(
            dataSets: data,
            xAxisLabels: xAxisLabels,
            chartStyle: chartStyle
        )
    }
}
