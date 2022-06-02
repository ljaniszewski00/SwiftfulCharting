//
//  AdjustDataView.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 31/05/2022.
//

import SwiftUI

struct AdjustDataView: View {
    @EnvironmentObject private var chartViewModel: ChartViewModel
    @EnvironmentObject private var accentColorManager: AccentColorManager
    
    @Environment(\.colorScheme) var colorScheme
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 70) {
                VStack(alignment: .leading) {
                    Text("From:")
                        .font(.title2)
                        .bold()
                    Picker("", selection: $chartViewModel.base) {
                        ForEach(chartViewModel.supportedSymbols, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(width: screenWidth * 0.8, height: screenHeight * 0.05)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke()
                            .foregroundColor(Color(uiColor: .systemGray2))
                    }
                    Text("Choose a currency from which you want to convert")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(width: screenWidth * 0.8, height: screenHeight * 0.1)
                .padding(.top, 100)
                
                VStack(alignment: .leading) {
                    Text("To:")
                        .font(.title2)
                        .bold()
                    if chartViewModel.apiCallType == .latestRates || chartViewModel.apiCallType == .historicalRates {
                        NavigationLink(destination: buildMultiplePickList(), isActive: $chartViewModel.showSymbolsList) {
                            Button(action: {
                                chartViewModel.showSymbolsList = true
                            }, label: {
                                Text("Choose symbols - \(chartViewModel.symbols.count) chosen")
                                    .frame(width: screenWidth * 0.8, height: screenHeight * 0.05)
                                    .background {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke()
                                            .foregroundColor(Color(uiColor: .systemGray2))
                                    }
                            })
                        }
                    } else {
                        Picker("", selection: $chartViewModel.convertTo) {
                            ForEach(chartViewModel.supportedSymbols, id: \.self) {
                                Text($0)
                            }
                        }
                        .frame(width: screenWidth * 0.8, height: screenHeight * 0.05)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke()
                                .foregroundColor(Color(uiColor: .systemGray2))
                        }
                    }
                    Text("Choose a currency to which you want to convert")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(width: screenWidth * 0.8, height: screenHeight * 0.1)
                
                if chartViewModel.apiCallType == .historicalRates {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Choose Date:")
                                .font(.title2)
                                .bold()
                            DatePicker("", selection: $chartViewModel.startingDate, in: getDateFrom(date: "2013-12-24")...Date(), displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .padding(.trailing, screenWidth * 0.46)
                            Text("Choose a date from which you want to gather data")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        Spacer()
                    }
                    .frame(width: screenWidth * 0.8, height: screenHeight * 0.1)
                }
                
                if chartViewModel.apiCallType == .convert {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Choose Starting Date:")
                                .font(.title2)
                                .bold()
                            DatePicker("", selection: $chartViewModel.startingDate, in: getDateFrom(date: "2013-12-24")...Date(), displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .padding(.trailing, screenWidth * 0.46)
                            Text("Choose a starting date from which you want to gather data")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        Spacer()
                    }
                    .frame(width: screenWidth * 0.8, height: screenHeight * 0.1)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Choose Ending Date:")
                                .font(.title2)
                                .bold()
                            DatePicker("", selection: $chartViewModel.endingDate, in: chartViewModel.startingDate...(addDaysToDate(days: 5, date: chartViewModel.startingDate) > Date() ? Date() : addDaysToDate(days: 5, date: chartViewModel.startingDate)), displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .padding(.trailing, screenWidth * 0.46)
                            Text("Choose an ending date from which you want to gather data")
                                .font(.callout)
                                .foregroundColor(.gray)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        Spacer()
                    }
                    .frame(width: screenWidth * 0.8, height: screenHeight * 0.1)
                    
                    VStack(alignment: .leading) {
                        Text("Amount:")
                            .font(.title2)
                            .bold()
                        TextField("", text: $chartViewModel.amount)
                            .keyboardType(.decimalPad)
                            .padding()
                            .frame(height: screenHeight * 0.05)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke()
                                    .foregroundColor(Color(uiColor: .systemGray2))
                            }
                        Text("Provide an amount you want to convert")
                            .font(.callout)
                            .foregroundColor(.gray)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(width: screenWidth * 0.8, height: screenHeight * 0.1)
                }
                
                if chartViewModel.apiCallType == .latestRates || chartViewModel.apiCallType == .historicalRates {
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            chartViewModel.oldStartingDate = chartViewModel.startingDate
                            chartViewModel.showProgressIndicator = true
                            switch chartViewModel.apiCallType {
                            case .latestRates:
                                chartViewModel.fetchLatestRates {
                                    chartViewModel.prepareLatestRatesAndHistoricalRatesChartData()
                                    chartViewModel.showProgressIndicator = false
                                    chartViewModel.showChartView = true
                                }
                            case .historicalRates:
                                chartViewModel.fetchHistoricalRates {
                                    chartViewModel.prepareLatestRatesAndHistoricalRatesChartData()
                                    chartViewModel.showProgressIndicator = false
                                    chartViewModel.showChartView = true
                                }
                            case .convert:
                                chartViewModel.fetchConvert {
                                    chartViewModel.prepareConvertChartData()
                                    chartViewModel.showProgressIndicator = false
                                    chartViewModel.showChartView = true
                                }
                            }
                        }
                    }, label: {
                        Text("Generate Chart")
                            .foregroundColor(.white)
                            .bold()
                    })
                    .frame(width: screenWidth * 0.9, height: screenHeight * 0.06)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.accentColor)
                    }
                    Spacer()
                }
                .padding(.bottom, screenHeight * 0.05)
            }
            .if(chartViewModel.showProgressIndicator) {
                $0
                    .blur(radius: 20)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color(uiColor: .systemGray6))
                                .frame(width: screenWidth * 0.55, height: screenHeight * 0.23)
                                .shadow(radius: 30)
                            
                            VStack(spacing: 40) {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                Text("Generating chart...")
                                    .font(.title2)
                                    .bold()
                                    .padding()
                            }
                        }
                    }
            }
            .navigationTitle("Setup Your Chart")
            .navigationBarHidden(false)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    func buildMultiplePickList() -> some View {
        List {
            ForEach(chartViewModel.searchResults, id: \.self) { supportedSymbol in
                HStack {
                    Text(supportedSymbol)
                    Spacer()
                    if chartViewModel.symbols.contains(supportedSymbol) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.accentColor)
                    }
                }
                .onTapGesture {
                    if chartViewModel.symbols.contains(supportedSymbol) {
                        for (index, symbol) in chartViewModel.symbols.enumerated() {
                            if symbol == supportedSymbol {
                                chartViewModel.symbols.remove(at: index)
                            }
                        }
                    } else {
                        chartViewModel.symbols.append(supportedSymbol)
                    }
                }
            }
        }
        .searchable(text: $chartViewModel.searchText, prompt: "Search Currencies")
    }
}

struct AdjustDataView_Previews: PreviewProvider {
    static var previews: some View {
        AdjustDataView()
            .environmentObject(ChartViewModel())
    }
}
