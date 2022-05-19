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
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                NavigationLink(destination: SettingsView().environmentObject(chartViewModel), isActive: $switchToSettingsView) {
                    Button("Start") {
                        withAnimation() {
                            switchToSettingsView = true
                        }
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke()
                            .frame(width: screenWidth * 0.9, height: screenHeight * 0.06)
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
