//
//  SwiftfulChartingApp.swift
//  SwiftfulCharting
//
//  Created by Users on 18/05/2022.
//

import SwiftUI

@main
struct SwiftfulChartingApp: App {
    @StateObject private var accentColorManager = AccentColorManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(accentColorManager)
                .accentColor(Color(uiColor: accentColorManager.accentColor.rawValue))
        }
    }
}
