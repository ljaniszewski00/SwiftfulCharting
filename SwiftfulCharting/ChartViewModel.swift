//
//  ChartViewModel.swift
//  SwiftfulCharting
//
//  Created by Users on 19/05/2022.
//

import Foundation

class ChartViewModel: ObservableObject {
    @Published var choosenCurrency: String = ""
    var currencies: [String] = ["PLN", "USD", "CAD", "SOT"]
    
    func fetchData() {
        let headers = [
            "X-RapidAPI-Host": "currency-converter5.p.rapidapi.com",
            "X-RapidAPI-Key": "8d3c69b775mshcc24b34f5cf077dp1dea3bjsn71f7afa7ced8"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://currency-converter5.p.rapidapi.com/currency/convert?format=json&from=AUD&to=CAD&amount=1")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
            }
        })

        dataTask.resume()
    }
    
}
