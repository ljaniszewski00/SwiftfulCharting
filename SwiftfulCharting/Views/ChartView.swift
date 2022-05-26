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
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(spacing: 60) {
            HStack {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Convert Currency")
                        .font(.title2)
                        .bold()
                    
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
            }
            
            LineView(data: Array(chartViewModel.historicalCurrencyChartData.values), title: "Currencies values", legend: "Value")
                .padding()
            
            Spacer()
        }
        .padding()
        .task {
            await chartViewModel.fetchHistoricalCurrencyData()
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView().environmentObject(ChartViewModel())
    }
}
