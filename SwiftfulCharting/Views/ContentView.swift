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
    
    @Environment(\.colorScheme) var colorScheme
    
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
                                        .bold()
                                        .foregroundColor(colorScheme == .light ? .white : .accentColor)
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: buildColorPickerView(), isActive: $chartViewModel.showContentViewColorSheet) {
                            Button(action: {
                                withAnimation {
                                    chartViewModel.showContentViewColorSheet = true
                                }
                            }, label: {
                                Image(systemName: "gearshape.fill")
                            })
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    func buildColorPickerView() -> some View {
        ScrollView(.vertical) {
            Text("Adjust Theme Color")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.accentColor)
                .padding(.bottom, 40)
            
            LazyVGrid(columns: [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())]) {
                ForEach(accentColorManager.availableColors, id: \.self) { color in
                    if accentColorManager.accentColor == color {
                        ZStack(alignment: .bottomTrailing) {
                            Circle()
                                .foregroundColor(Color(uiColor: color.rawValue))
                                .frame(width: 80, height: 80)
                                .onTapGesture {
                                    accentColorManager.accentColor = color
                                }
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .foregroundColor(colorScheme == .light ? .black : .white)
                                .frame(width: 30, height: 30)
                        }
                    } else {
                        Circle()
                            .foregroundColor(Color(uiColor: color.rawValue))
                            .frame(width: 80, height: 80)
                            .onTapGesture {
                                accentColorManager.accentColor = color
                            }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
