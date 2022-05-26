//
//  ContentView.swift
//  SwiftfulCharting
//
//  Created by Users on 18/05/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var chartViewModel = ChartViewModel()
    @State private var switchToSettingsView: Bool = false
    @State private var switchToInfoView: Bool = false
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationView {
            VStack(spacing: 60) {
                Image(uiImage: UIImage(named: "ChartsImage")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack(spacing: 60) {
                    NavigationLink(destination: SettingsView().environmentObject(chartViewModel), isActive: $switchToSettingsView) {
                        Button(action: {
                            withAnimation() {
                                switchToSettingsView = true
                            }
                        }, label: {
                            Text("Start")
                                .foregroundColor(.white)
                        })
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: screenWidth * 0.9, height: screenHeight * 0.06)
                        }
                    }
                    
                    NavigationLink(destination: InfoView(), isActive: $switchToInfoView) {
                        Button(action: {
                            withAnimation() {
                                switchToInfoView = true
                            }
                        }, label: {
                            Text("About The App")
                                .foregroundColor(.blue)
                        })
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke()
                                .frame(width: screenWidth * 0.9, height: screenHeight * 0.06)
                        }
                    }
                }
                .padding(.bottom, screenHeight * 0.05)
            }
            .navigationTitle("SwiftfulCharting")
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
