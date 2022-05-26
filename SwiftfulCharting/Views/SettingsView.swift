//
//  SettingsView.swift
//  SwiftfulCharting
//
//  Created by Users on 18/05/2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var chartViewModel: ChartViewModel
    @State private var switchToChartView: Bool = false
    @State private var searchText: String = ""
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 50) {
                HStack {
                    VStack(alignment: .leading, spacing: 50) {
                        Text("Convert currency")
                            .font(.title2)
                        
                        HStack(spacing: 40) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("From")
                                Picker("", selection: $chartViewModel.fromCurrency) {
                                    ForEach(chartViewModel.availableCurrencies, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .frame(width: screenWidth * 0.15, height: screenHeight * 0.05)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke()
                                        .foregroundColor(Color(uiColor: .systemGray2))
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("To")
                                Picker("", selection: $chartViewModel.toCurrency) {
                                    ForEach(chartViewModel.availableCurrencies, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .frame(width: screenWidth * 0.15, height: screenHeight * 0.05)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke()
                                        .foregroundColor(Color(uiColor: .systemGray2))
                                }
                            }
                        }
                        
                    }
                    
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Provide an amount:")
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
                    
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Choose starting date:")
                        DatePicker("", selection: $chartViewModel.startingDate, in: chartViewModel.getDateFrom(date: "2010-01-01")...Date(), displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .frame(width: screenWidth * 0.3, height: screenHeight * 0.05)
                    }
                    
                    Spacer()
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Choose ending date:")
                        DatePicker("", selection: $chartViewModel.endingDate, in: chartViewModel.getDateFrom(date: "2010-01-01")...Date(), displayedComponents: .date)
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
            
            NavigationLink(destination: ChartView().environmentObject(chartViewModel), isActive: $switchToChartView) {
                Button(action: {
                    withAnimation() {
                        switchToChartView = true
                    }
                }, label: {
                    Text("Generate Chart")
                        .foregroundColor(.white)
                })
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: screenWidth * 0.9, height: screenHeight * 0.06)
                }
            }
            .padding(.bottom, screenHeight * 0.05)
        }
        .navigationTitle("Setup your Chart")
        .task {
            await chartViewModel.fetchAvailableCurrenciesData()
        }
    }
    
//    var searchResults: [String] {
//        if !chartViewModel.availableCurrencies.isEmpty {
//            if searchText.isEmpty {
//                return Array(self.chartViewModel.availableCurrencies.keys)
//            } else {
//                var searchResults = [String]()
//                for key in self.chartViewModel.availableCurrencies.keys {
//                    if let value = self.chartViewModel.availableCurrencies[key] {
//                        if value.lowercased().contains(searchText.lowercased()) || key.lowercased().contains(searchText.lowercased()) {
//                            searchResults.append(key)
//                        }
//                    }
//                }
//                return searchResults
//            }
//        } else {
//            return [String]()
//        }
//    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(ChartViewModel())
    }
}
