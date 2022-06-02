//
//  InfoView.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 26/05/2022.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("How to use?")
                        .font(.title)
                        .bold()
                        .padding(.top, 30)
                    Text("Choose currency which you want to convert, provide proper amount and then currency to which you want to convert. Click generate chart.")
                        .fixedSize(horizontal: false, vertical: true)
                    Text("After data has been downloaded from API, the chart will be generated.")
                        .fixedSize(horizontal: false, vertical: true)
                    Text("You can zoom it and see particular values by clicking on any of it's fragments. What's more, you can change currency at any time and new chart will be generated.")
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.bottom, 30)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("3rd party software")
                        .font(.title)
                        .bold()
                    
                    HStack {
                        Link(destination: URL(string: "https://rapidapi.com/fixer/api/fixer-currency/")!) {
                            Text("Fixer Currency")
                                .bold()
                        }
                        .offset(y: -10.5)
                        Text("API provides all the data for chart generating.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .font(.callout)
                    
                    HStack {
                        Link(destination: URL(string: "https://github.com/willdale/SwiftUICharts")!) {
                            Text("SwiftUICharts")
                                .bold()
                        }
                        .offset(y: -10.5)
                        Text("provides simple way to generate all the charts.")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .font(.callout)
                }
                .padding(.bottom, 70)
                
                Text("Designed & Programmed by")
                    .font(.title3)
                Text("Łukasz Janiszewski")
                    .font(.title)
                    .bold()
                HStack(spacing: 6) {
                    Text("Check out my")
                    Link(destination: URL(string: "https://github.com/ljaniszewski00")!, label: {
                        Text("GitHub")
                            .bold()
                    })
                }
                .font(.callout)
                
                Spacer()
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("SwiftfulCharting")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
