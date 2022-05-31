//
//  ChooseCallView.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 30/05/2022.
//

import SwiftUI

struct ChooseCallView: View {
    @EnvironmentObject private var chartViewModel: ChartViewModel
    @EnvironmentObject private var accentColorManager: AccentColorManager
    
    @Environment(\.colorScheme) var colorScheme
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 50) {
                Spacer()
                
                NavigationLink(destination: AdjustDataView().environmentObject(chartViewModel), isActive: $chartViewModel.showAdjustDataView) {
                    Button(action: {
                        chartViewModel.apiCallType = .latestRates
                        chartViewModel.showAdjustDataView = true
                    }, label: {
                        VStack(spacing: 15) {
                            Text(chartViewModel.apiCallNames[0])
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.accentColor)
                            Text(chartViewModel.apiCallTypes[chartViewModel.apiCallNames[0]]!)
                                .font(.headline)
                                .foregroundColor(colorScheme == .light ? .black : .white)
                        }
                    })
                }
                .padding()
                .frame(width: screenWidth * 0.9, height: screenHeight * 0.2)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color(uiColor: .systemGray6))
                }
                
                NavigationLink(destination: AdjustDataView().environmentObject(chartViewModel), isActive: $chartViewModel.showAdjustDataView) {
                    Button(action: {
                        chartViewModel.apiCallType = .historicalRates
                        chartViewModel.showAdjustDataView = true
                    }, label: {
                        VStack(spacing: 15) {
                            Text(chartViewModel.apiCallNames[1])
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.accentColor)
                            Text(chartViewModel.apiCallTypes[chartViewModel.apiCallNames[1]]!)
                                .font(.headline)
                                .foregroundColor(colorScheme == .light ? .black : .white)
                        }
                    })
                }
                .padding()
                .frame(width: screenWidth * 0.9, height: screenHeight * 0.2)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color(uiColor: .systemGray6))
                }
                
                NavigationLink(destination: AdjustDataView().environmentObject(chartViewModel), isActive: $chartViewModel.showAdjustDataView) {
                    Button(action: {
                        chartViewModel.apiCallType = .convert
                        chartViewModel.showAdjustDataView = true
                    }, label: {
                        VStack(spacing: 15) {
                            Text(chartViewModel.apiCallNames[2])
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.accentColor)
                            Text(chartViewModel.apiCallTypes[chartViewModel.apiCallNames[2]]!)
                                .font(.headline)
                                .foregroundColor(colorScheme == .light ? .black : .white)
                        }
                    })
                }
                .padding()
                .frame(width: screenWidth * 0.9, height: screenHeight * 0.2)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color(uiColor: .systemGray6))
                }
                
                Spacer()
            }
        }
        .navigationTitle("Select Data Type")
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChooseCallView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseCallView()
            .environmentObject(ChartViewModel())
    }
}
