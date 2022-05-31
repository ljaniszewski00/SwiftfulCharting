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
    
//    var calculatedSpacing: CGFloat {
//        switch chartViewModel.historicalCurrencyData.0.count {
//        case 1:
//            return 0
//        case 2:
//            return 110
//        case 3:
//            return 70
//        case 4:
//            return 45
//        case 5:
//            return 25
//        default:
//            return 0
//        }
//    }
    
    var body: some View {
        if chartViewModel.showContentView {
            ContentView()
                .environmentObject(accentColorManager)
                .transition(.slide)
        } else {
            NavigationView {
                VStack {
                    
//                    BarChartView(data: chartViewModel.chartData, title: "Currencies values", legend: "Value", style: .init(formSize: ChartForm.medium), dropShadow: true)
                    
//                    LineView(data: chartViewModel.historicalCurrencyData.1, title: "Currencies values", legend: "Value", style: ChartStyle(backgroundColor: colorScheme == .light ? .white : .black, accentColor: .accentColor, gradientColor: .init(start: .accentColor, end: .accentColor), textColor: colorScheme == .light ? .black : .white, legendTextColor: .gray, dropShadowColor: .black))
//                        .padding()
//
//                    HStack(spacing: calculatedSpacing) {
//                        ForEach(chartViewModel.historicalCurrencyData.0, id: \.self) { date in
//                            Text(date)
//                                .font(.footnote)
//                                .foregroundColor(.gray)
//                                .fixedSize(horizontal: false, vertical: true)
//                                .frame(width: 45)
//                                .offset(x: 20, y: -190)
//                        }
//                    }
                    
                    switch chartViewModel.apiCallType {
                    case .latestRates:
                        if let latestRatesModel = chartViewModel.latestRatesModel {
                            LineView(data: Array(latestRatesModel.rates.values), title: "Currencies values", legend: "Value", style: ChartStyle(backgroundColor: colorScheme == .light ? .white : .black, accentColor: .accentColor, gradientColor: .init(start: .accentColor, end: .accentColor), textColor: colorScheme == .light ? .black : .white, legendTextColor: .gray, dropShadowColor: .black))
                        }
                    case .historicalRates:
                        if let historicalRatesModel = chartViewModel.historicalRatesModel {
                            LineView(data: Array(historicalRatesModel.rates.values), title: "Currencies values", legend: "Value", style: ChartStyle(backgroundColor: colorScheme == .light ? .white : .black, accentColor: .accentColor, gradientColor: .init(start: .accentColor, end: .accentColor), textColor: colorScheme == .light ? .black : .white, legendTextColor: .gray, dropShadowColor: .black))
                        }
                    case .convert:
                        if let convertModels = chartViewModel.convertModels {
                            
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
