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
        VStack {
            Text("Choose currency for your new chart:")
                .font(.body)
                .padding(.bottom)
            List {
                ForEach(searchResults, id: \.self) { currency in
                    NavigationLink(destination: ChartView().environmentObject(chartViewModel), isActive: $switchToChartView) {
                        Button(action: {
                            withAnimation() {
                                chartViewModel.fromCurrency = currency
                                switchToChartView = true
                            }
                        }, label: {
                            Text(currency)
                        })
                    }
                }
            }
            .searchable(text: $searchText)
        }
        .task {
            await chartViewModel.fetchAvailableCurrenciesData()
        }
    }
    
    var searchResults: [String] {
        if !chartViewModel.availableCurrencies.isEmpty {
            if searchText.isEmpty {
                return Array(self.chartViewModel.availableCurrencies.keys)
            } else {
                var searchResults = [String]()
                for key in self.chartViewModel.availableCurrencies.keys {
                    if let value = self.chartViewModel.availableCurrencies[key] {
                        if value.lowercased().contains(searchText.lowercased()) || key.lowercased().contains(searchText.lowercased()) {
                            searchResults.append(key)
                        }
                    }
                }
                return searchResults
            }
        } else {
            return [String]()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(ChartViewModel())
    }
}
