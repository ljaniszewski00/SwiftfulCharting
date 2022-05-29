//
//  SettingsView.swift
//  SwiftfulCharting
//
//  Created by Users on 18/05/2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var chartViewModel: ChartViewModel
    @EnvironmentObject private var accentColorManager: AccentColorManager
    
    @Environment(\.colorScheme) var colorScheme
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 25) {
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Convert currency")
                            .font(.title2)
                            .bold()
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("From:")
                                .bold()
                            Picker("", selection: $chartViewModel.fromCurrency) {
                                ForEach(chartViewModel.availableCurrencies, id: \.self) {
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
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("To:")
                                .bold()
                            Picker("", selection: $chartViewModel.toCurrency) {
                                ForEach(chartViewModel.availableCurrencies, id: \.self) {
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
                        
                        VStack(alignment: .leading) {
                            Text("Amount:")
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
                        }
                    }
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Choose starting date:")
                            .bold()
                        DatePicker("", selection: $chartViewModel.startingDate, in: getDateFrom(date: "2010-01-01")...Date(), displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .frame(width: screenWidth * 0.3, height: screenHeight * 0.05)
                    }
                    
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Choose ending date:")
                            .bold()
                        DatePicker("", selection: $chartViewModel.endingDate, in: chartViewModel.startingDate...(addDaysToDate(days: 4, date: chartViewModel.startingDate) > Date() ? Date() : addDaysToDate(days: 4, date: chartViewModel.startingDate)), displayedComponents: .date)
                            .frame(width: screenWidth * 0.3, height: screenHeight * 0.05)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .frame(width: screenWidth * 0.9, height: screenHeight * 0.65)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .stroke()
                    .foregroundColor(Color(uiColor: .systemGray2))
            }
            
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        chartViewModel.oldStartingDate = chartViewModel.startingDate
                        chartViewModel.showProgressIndicator = true
                        chartViewModel.fetchHistoricalCurrencyData() {
                            chartViewModel.showProgressIndicator = false
                            chartViewModel.showChartView = true
                        }
                    }
                }, label: {
                    Text("Generate Chart")
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
        .if(chartViewModel.showProgressIndicator) {
            $0
                .blur(radius: 20)
                .overlay {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color(uiColor: .systemGray6))
                                .frame(width: screenWidth * 0.35, height: screenHeight * 0.15)
                                .shadow(radius: 30)
                        }
                    
                }
        }
        .navigationTitle("Setup Your Chart")
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(ChartViewModel())
    }
}
