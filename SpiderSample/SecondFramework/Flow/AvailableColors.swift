//
//  AvailableColors.swift
//  SecondFramework
//
//  Created by Andre Luiz Salla on 12/11/20.
//  Copyright © 2020 Andre Luiz Salla. All rights reserved.
//

import Foundation
import UIKit

enum AvailableColors: String, CaseIterable {
    
    case blue = "Azul"
    case orange = "Laranja"
    case red = "Vermelho"
    case yellow = "Amarelo"
    
    var color: String {
        switch self {
        case .blue: return "#0000FF"
        case .orange: return "#FFA500"
        case .red: return "#FF0000"
        case .yellow: return "#EEDB00"
        }
    }
}
