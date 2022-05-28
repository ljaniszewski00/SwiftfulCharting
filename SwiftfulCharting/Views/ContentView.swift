//
//  ContentView.swift
//  SwiftfulCharting
//
//  Created by Users on 18/05/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var chartViewModel = ChartViewModel()
    @EnvironmentObject private var accentColorManager: AccentColorManager
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        if chartViewModel.showChartView {
            ChartView()
                .environmentObject(chartViewModel)
                .environmentObject(accentColorManager)
                .transition(.slide)
        } else {
            NavigationView {
                VStack(spacing: 60) {
                    Image(uiImage: UIImage(named: "ChartsImage")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    VStack(spacing: 20) {
                        HStack {
                            Spacer()
                            NavigationLink(destination: SettingsView().environmentObject(chartViewModel).environmentObject(accentColorManager), isActive: $chartViewModel.showSettingsView) {
                                Button(action: {
                                    withAnimation() {
                                        chartViewModel.showSettingsView = true
                                    }
                                }, label: {
                                    Text("Start")
                                        .foregroundColor(.white)
                                        .bold()
                                })
                                .frame(width: screenWidth * 0.9, height: screenHeight * 0.06)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                }
                            }
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            NavigationLink(destination: InfoView(), isActive: $chartViewModel.showInfoView) {
                                Button(action: {
                                    withAnimation() {
                                        chartViewModel.showInfoView = true
                                    }
                                }, label: {
                                    Text("About The App")
                                        .foregroundColor(.white)
                                        .bold()
                                })
                                .frame(width: screenWidth * 0.9, height: screenHeight * 0.06)
                                .background {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke()
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.bottom, screenHeight * 0.05)
                }
                .navigationTitle("SwiftfulCharting")
                .padding()
            }
            .task {
                await chartViewModel.fetchAvailableCurrenciesData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
