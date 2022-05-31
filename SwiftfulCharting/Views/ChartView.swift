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
    
    @Environment(\.colorScheme) var colorScheme
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var calculatedSpacing: CGFloat {
        switch chartViewModel.latestRatesModel?.rates.count {
        case 1:
            return 0
        case 2:
            return 125
        case 3:
            return 90
        case 4:
            return 60
        case 5:
            return 40
        default:
            return 0
        }
    }
    
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
                            Text("Presenting latest rates values")
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
                        
                        if let latestRatesModel = chartViewModel.latestRatesModel {
 
                        }
                    case .historicalRates:
                        if let historicalRatesModel = chartViewModel.historicalRatesModel {

                        }
                    case .convert:
                        if let convertModels = chartViewModel.convertModels {
                            FilledLineChart(chartData: chartViewModel.prepareConvertChartData())
                                .pointMarkers(chartData: chartViewModel.prepareConvertChartData())
                                .touchOverlay(chartData: chartViewModel.prepareConvertChartData(), specifier: "%.0f")
                                .averageLine(chartData: chartViewModel.prepareConvertChartData(),
                                             strokeStyle: StrokeStyle(lineWidth: 3, dash: [5,10]))
                                .xAxisGrid(chartData: chartViewModel.prepareConvertChartData())
                                .yAxisGrid(chartData: chartViewModel.prepareConvertChartData())
                                .xAxisLabels(chartData: chartViewModel.prepareConvertChartData())
                                .yAxisLabels(chartData: chartViewModel.prepareConvertChartData())
                                .infoBox(chartData: chartViewModel.prepareConvertChartData())
                                .headerBox(chartData: chartViewModel.prepareConvertChartData())
                                .id(chartViewModel.prepareConvertChartData().id)
                                .frame(width: screenWidth * 0.9, height: screenHeight * 0.6)
                            
                            HStack(spacing: calculatedSpacing) {
                                ForEach(chartViewModel.convertModels!, id: \.self) { convertModel in
                                    Text(String(convertModel.date))
                                        .font(.footnote)
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .offset(x: 20)
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
                .if(chartViewModel.apiCallType == .convert) {
                    $0
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination: buildSettingsSheetView(), isActive: $chartViewModel.showChartViewSettingsView) {
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
    }
    
    @ViewBuilder
    func buildSettingsSheetView() -> some View {
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
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    withAnimation {
                        chartViewModel.filterDataByNewDates()
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
