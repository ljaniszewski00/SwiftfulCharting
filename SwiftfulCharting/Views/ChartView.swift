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
    
    var body: some View {
        if chartViewModel.showContentView {
            ContentView()
                .environmentObject(accentColorManager)
                .transition(.slide)
        } else {
            NavigationView {
                VStack {
//                    BarChartView(data: chartViewModel.chartData, title: "Currencies values", legend: "Value", style: .init(formSize: ChartForm.medium), dropShadow: true)
                    
                    LineView(data: Array(chartViewModel.historicalCurrencyData.values), title: "Currencies values", legend: "Value", style: .init(formSize: ChartForm.medium))
                        .padding()
                        .padding(.bottom, 50)
                    
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
                                .foregroundColor(.red)
                        }
                        
                        Spacer()
                    }
                    .padding(.bottom, screenHeight * 0.05)
                }
                .padding()
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
    
    @ViewBuilder
    func buildSettingsSheetView() -> some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading) {
                Text("Adjust Chart Data")
                    .font(.largeTitle)
                    .bold()
            }
            .padding()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Choose starting date:")
                        .bold()
                    DatePicker("", selection: $chartViewModel.startingDate, in: chartViewModel.oldStartingDate...Date(), displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .frame(width: screenWidth * 0.3, height: screenHeight * 0.05)
                }
                
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Choose ending date:")
                        .bold()
                    DatePicker("", selection: $chartViewModel.endingDate, in: chartViewModel.startingDate...Date(), displayedComponents: .date)
                        .frame(width: screenWidth * 0.3, height: screenHeight * 0.05)
                }
                
                Spacer()
            }
            
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
        ChartView().environmentObject(ChartViewModel())
    }
}
