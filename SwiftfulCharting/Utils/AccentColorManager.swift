//
//  AccentColorManager.swift
//  SwiftfuSwiftfulChartingCharting
//
//  Created by Łukasz Janiszewski on 28/05/2022.
//

import SwiftUI

class AccentColorManager: ObservableObject {
    @Published var accentColor: accentColors = .purple
}

enum accentColors {
    case blue
    case red
    case green
    case purple
    case yellow
}

extension accentColors: RawRepresentable {
    typealias RawValue = UIColor
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1): self = .blue
        case #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1): self = .red
        case #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1): self = .green
        case #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1): self = .purple
        case #colorLiteral(red: 0, green: 0, blue:0, alpha: 1): self = .yellow
        default: return nil
        }
    }
    
    var rawValue: UIColor {
        switch self {
        case .blue: return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .red: return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case .green: return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .purple: return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case .yellow: return #colorLiteral(red: 0, green: 0, blue:0, alpha: 1)
        }
    }
}
