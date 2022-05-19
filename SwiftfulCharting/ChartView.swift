//
//  ChartView.swift
//  SwiftfulCharting
//
//  Created by Users on 18/05/2022.
//

import SwiftUI

struct ChartView: View {
    @EnvironmentObject private var chartViewModel: ChartViewModel
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                chartViewModel.fetchData()
            }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
