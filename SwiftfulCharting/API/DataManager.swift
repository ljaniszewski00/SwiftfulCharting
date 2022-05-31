//
//  DataManager.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 26/05/2022.
//

import Foundation

class DataManager {
    static var shared: DataManager {
        DataManager()
    }
    
    private init() {}
    
    func getSupportedSymbols(supportedSymbolsModel: SupportedSymbolsModel) -> [String] {
        var supportedSymbols = [String]()
        for supportedSymbol in supportedSymbolsModel.symbols {
            supportedSymbols.append(supportedSymbol.key + " - " + supportedSymbol.value)
        }
        return supportedSymbols.sorted()
    }
}

extension DataManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
