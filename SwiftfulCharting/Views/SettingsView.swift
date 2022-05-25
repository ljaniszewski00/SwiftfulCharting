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
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        VStack {
            Text("Choose currency for your new chart:")
                .font(.body)
                .padding(.bottom)
            List(chartViewModel.currencies, id: \.self) { currency in
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
        .task {
            await chartViewModel.fetchAvailableCurrenciesData()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(ChartViewModel())
    }
}
