//
//  ChartView.swift
//  SwiftfulCharting
//
//  Created by Users on 18/05/2022.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    @EnvironmentObject private var chartViewModel: ChartViewModel
    @EnvironmentObject private var accentColorManager: AccentColorManager
    @State private var showAverageLine: Bool = true
    
    @Environment(\.colorScheme) var colorScheme
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        if chartViewModel.showContentView {
            ContentView()
                .environmentObject(accentColorManager)
                .transition(.slide)
        } else {
            NavigationView {
                VStack {
                    switch chartViewModel.apiCallType {
                    case .latestRates:
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Presenting Lates Rates Values")
                                .font(.title)
                                .bold()
                            HStack {
                                Text("By converting:")
                                Text(chartViewModel.base)
                                    .bold()
                            }
                            HStack {
                                Text("To:")
                                HStack {
                                    ForEach(chartViewModel.symbols, id: \.self) { symbol in
                                        if !(symbol == chartViewModel.symbols.last) {
                                            Text(String(symbol.prefix(3)) + ",")
                                                .bold()
                                        } else {
                                            Text(String(symbol.prefix(3)))
                                                .bold()
                                        }
                                    }
                                }
                            }
                        }
                        
                        if let barChartData = chartViewModel.barChartData {
                            BarChart(chartData: barChartData)
                                .touchOverlay(chartData: barChartData, specifier: "%.0f")
                                .xAxisGrid(chartData: barChartData)
                                .yAxisGrid(chartData: barChartData)
                                .xAxisLabels(chartData: barChartData)
                                .yAxisLabels(chartData: barChartData)
                                .infoBox(chartData: barChartData)
                                .headerBox(chartData: barChartData)
                                .id(barChartData.id)
                                .frame(width: screenWidth * 0.9, height: screenHeight * 0.6)
                                .offset(y: -50)
                        }
                    case .historicalRates:
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Presenting Historical Rates Values")
                                .font(.title)
                                .bold()
                            HStack {
                                Text("By converting:")
                                Text(chartViewModel.base)
                                    .bold()
                            }
                            HStack {
                                Text("To:")
                                HStack {
                                    ForEach(chartViewModel.symbols, id: \.self) { symbol in
                                        if !(symbol == chartViewModel.symbols.last) {
                                            Text(String(symbol.prefix(3)) + ",")
                                                .bold()
                                        } else {
                                            Text(String(symbol.prefix(3)))
                                                .bold()
                                        }
                                    }
                                }
                            }
                            HStack {
                                Text("On:")
                                Text(convertDateToStringDate(date: chartViewModel.startingDate))
                                    .bold()
                            }
                        }
                        
                        if let barChartData = chartViewModel.barChartData {
                            BarChart(chartData: barChartData)
                                .touchOverlay(chartData: barChartData, specifier: "%.0f")
                                .xAxisGrid(chartData: barChartData)
                                .yAxisGrid(chartData: barChartData)
                                .xAxisLabels(chartData: barChartData)
                                .yAxisLabels(chartData: barChartData)
                                .infoBox(chartData: barChartData)
                                .headerBox(chartData: barChartData)
                                .id(barChartData.id)
                                .frame(width: screenWidth * 0.9, height: screenHeight * 0.6)
                                .offset(y: -50)
                        }
                    case .convert:
                        VStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Presenting Convert Values")
                                    .font(.title)
                                    .bold()
                                HStack {
                                    Text("By converting:")
                                    Text(chartViewModel.base)
                                        .bold()
                                }
                                HStack {
                                    Text("To:")
                                    Text(chartViewModel.convertTo)
                                        .bold()
                                }
                            }
                            
                            if let lineChartData = chartViewModel.lineChartData {
                                FilledLineChart(chartData: lineChartData)
                                    .pointMarkers(chartData: lineChartData)
                                    .touchOverlay(chartData: lineChartData, specifier: "%.0f")
                                    .if(showAverageLine) {
                                        $0
                                            .averageLine(chartData: lineChartData,
                                                          strokeStyle: StrokeStyle(lineWidth: 3, dash: [5,10]))
                                    }
                                    .xAxisGrid(chartData: lineChartData)
                                    .yAxisGrid(chartData: lineChartData)
                                    .xAxisLabels(chartData: lineChartData)
                                    .yAxisLabels(chartData: lineChartData)
                                    .infoBox(chartData: lineChartData)
                                    .headerBox(chartData: lineChartData)
                                    .id(lineChartData.id)
                                    .frame(width: screenWidth * 0.9, height: screenHeight * 0.6)
                                    .offset(y: -50)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                chartViewModel.showContentView = true
                            }
                        }, label: {
                            Text("Close")
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
                .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: whichSettingsView(), isActive: $chartViewModel.showChartViewSettingsView) {
                            Button(action: {
                                withAnimation {
                                    chartViewModel.showChartViewSettingsView = true
                                }
                            }, label: {
                                Image(systemName: "slider.horizontal.3")
                            })
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func whichSettingsView() -> some View {
        switch chartViewModel.apiCallType {
        case .latestRates:
            buildLatestRatesSettingsView()
        case .historicalRates:
            buildHistoricalRatesSettingsView()
        case .convert:
            buildConvertSettingsView()
        }
    }
    
    @ViewBuilder
    func buildLatestRatesSettingsView() -> some View {
        ScrollView(.vertical) {
            VStack(spacing: 40) {
                VStack(alignment: .leading) {
                    Text("Adjust Chart Data")
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 40) {
                    Text("Choose Destination Currencies:")
                        .font(.title2)
                        .bold()
                    
                    ForEach(chartViewModel.symbols, id: \.self) { symbol in
                        HStack {
                            Text(symbol)
                            Spacer()
                            if Array(chartViewModel.latestRatesModel!.rates.keys).contains(String(symbol.prefix(3))) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                                .frame(width: screenWidth * 0.79, height: screenHeight * 0.05)
                                .foregroundColor(.accentColor)
                        }
                        .padding(.horizontal)
                        .onTapGesture {
                            if Array(chartViewModel.latestRatesModel!.rates.keys).contains(String(symbol.prefix(3))) {
                                chartViewModel.latestRatesModel!.rates.removeValue(forKey: String(symbol.prefix(3)))
//                                for (index, thisSymbol) in chartViewModel.symbols.enumerated() {
//                                    if thisSymbol == symbol {
//                                        chartViewModel.symbols.remove(at: index)
//                                        break
//                                    }
//                                }
                            } else {
                                chartViewModel.latestRatesModel!.rates[String(symbol.prefix(3))] = 2.14
                            }
                        }
                    }
                    
                    Text("Choose currencies to which you want to convert base currency")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
            }
            .frame(width: screenWidth * 0.8)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    withAnimation {
                        chartViewModel.filterDataByNewDates()
                        chartViewModel.prepareLatestRatesAndHistoricalRatesChartData()
                        chartViewModel.showChartViewSettingsView = false
                    }
                }, label: {
                    Text("Update")
                        .foregroundColor(colorScheme == .light ? .white : .accentColor)
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
        .padding()
    }
    
    @ViewBuilder
    func buildHistoricalRatesSettingsView() -> some View {
        ScrollView(.vertical) {
            VStack(spacing: 40) {
                VStack(alignment: .leading) {
                    Text("Adjust Chart Data")
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 40) {
                    Text("Choose Destination Currencies:")
                        .font(.title2)
                        .bold()
                    
                    ForEach(chartViewModel.symbols, id: \.self) { symbol in
                        HStack {
                            Text(symbol)
                            Spacer()
                            if Array(chartViewModel.historicalRatesModel!.rates.keys).contains(String(symbol.prefix(3))) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                                .frame(width: screenWidth * 0.79, height: screenHeight * 0.05)
                                .foregroundColor(.accentColor)
                        }
                        .padding(.horizontal)
                        .onTapGesture {
                            if Array(chartViewModel.historicalRatesModel!.rates.keys).contains(String(symbol.prefix(3))) {
                                chartViewModel.historicalRatesModel!.rates.removeValue(forKey: String(symbol.prefix(3)))
//                                for (index, thisSymbol) in chartViewModel.symbols.enumerated() {
//                                    if thisSymbol == symbol {
//                                        chartViewModel.symbols.remove(at: index)
//                                        break
//                                    }
//                                }
                            } else {
                                chartViewModel.historicalRatesModel!.rates[String(symbol.prefix(3))] = 2.14
                            }
                        }
                    }
                    
                    Text("Choose currencies to which you want to convert base currency")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
            }
            .frame(width: screenWidth * 0.8)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    withAnimation {
                        chartViewModel.filterDataByNewDates()
                        chartViewModel.prepareLatestRatesAndHistoricalRatesChartData()
                        chartViewModel.showChartViewSettingsView = false
                    }
                }, label: {
                    Text("Update")
                        .foregroundColor(colorScheme == .light ? .white : .accentColor)
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
        .padding()
    }
    
    @ViewBuilder
    func buildConvertSettingsView() -> some View {
        VStack(spacing: 70) {
            VStack(alignment: .leading) {
                Text("Adjust Chart Data")
                    .font(.largeTitle)
                    .bold()
            }
            .padding()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Choose Starting Date:")
                        .font(.title2)
                        .bold()
                    DatePicker("", selection: $chartViewModel.startingDate, in: chartViewModel.oldStartingDate...Date(), displayedComponents: .date)
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
                HStack {
                    Text("Show Average Line:")
                        .font(.title2)
                        .bold()
                        .frame(width: screenWidth * 0.5)
                    Toggle("", isOn: $showAverageLine)
                }
                
                Text("Choose whether a line on a chart meaning the average in presented data should be drawn")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(width: screenWidth * 0.8, height: screenHeight * 0.1)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    withAnimation {
                        chartViewModel.filterDataByNewDates()
                        chartViewModel.prepareConvertChartData()
                        chartViewModel.showChartViewSettingsView = false
                    }
                }, label: {
                    Text("Update")
                        .foregroundColor(colorScheme == .light ? .white : .accentColor)
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
        .padding()
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
            .environmentObject(ChartViewModel())
    }
}
