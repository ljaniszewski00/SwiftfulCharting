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
                    LineView(data: Array(chartViewModel.historicalCurrencyChartData.values), title: "Currencies values", legend: "Value")
                        .padding()
                        .padding(.top, 50)
                    
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
                .task {
                    await chartViewModel.fetchHistoricalCurrencyData()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            withAnimation {
                                chartViewModel.showChartViewSettingsSheet = true
                            }
                        }, label: {
                            Image(systemName: "slider.horizontal.3")
                        })
                    }
                }
                .sheet(isPresented: $chartViewModel.showChartViewSettingsSheet, onDismiss: {
                    chartViewModel.showChartViewSettingsSheet = false
                }, content: {
                    buildSettingsSheetView()
                })
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
            
            VStack(alignment: .leading, spacing: 10) {
                Text("From:")
                    .bold()
                HStack {
                    Spacer()
                    Picker("", selection: $chartViewModel.fromCurrency) {
                        ForEach(chartViewModel.availableCurrencies, id: \.self) {
                            Text($0)
                                .foregroundColor(.accentColor)
                        }
                    }
                    .frame(width: screenWidth * 0.9, height: screenHeight * 0.05)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke()
                            .foregroundColor(Color(uiColor: .systemGray2))
                    }
                    Spacer()
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("To:")
                    .bold()
                HStack {
                    Spacer()
                    Picker("", selection: $chartViewModel.toCurrency) {
                        ForEach(chartViewModel.availableCurrencies, id: \.self) {
                            Text($0)
                                .foregroundColor(.accentColor)
                        }
                    }
                    .frame(width: screenWidth * 0.9, height: screenHeight * 0.05)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke()
                            .foregroundColor(Color(uiColor: .systemGray2))
                    }
                    Spacer()
                }
            }
            
            VStack(alignment: .leading) {
                Text("Amount:")
                    .bold()
                HStack {
                    Spacer()
                    TextField("", text: $chartViewModel.amount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .frame(width: screenWidth * 0.9, height: screenHeight * 0.05)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke()
                                .foregroundColor(Color(uiColor: .systemGray2))
                        }
                    Spacer()
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Choose starting date:")
                        .bold()
                    DatePicker("", selection: $chartViewModel.startingDate, in: chartViewModel.getDateFrom(date: "2010-01-01")...Date(), displayedComponents: .date)
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
                    withAnimation() {
                        chartViewModel.showChartViewSettingsSheet = false
                    }
                }, label: {
                    Text("Update")
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
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView().environmentObject(ChartViewModel())
    }
}
