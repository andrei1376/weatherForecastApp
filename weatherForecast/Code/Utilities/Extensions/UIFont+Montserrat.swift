//
//  CustomFont.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 02/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import UIKit

enum FontSize: CGFloat {
    case xxLarge = 44
    case large = 20
    case regularPlus = 18
    case regular = 16
    case small = 14
    case verySmall = 10

}

extension UIFont {
    static func montserrat(of weight: UIFont.Weight, withSize size: FontSize) -> UIFont {
        let fontName = "Montserrat-" + weight.name
        return UIFont(name: fontName, size: size.rawValue) ?? UIFont.systemFont(ofSize: size.rawValue, weight: weight)
    }
}

extension UIFont.Weight {
    var name: String {
        switch self {
        case .medium:
            return "Medium"
        case .light:
            return "Light"
        case .semibold:
            return "Semibold"
        default:
            return "Medium"
        }
    }
}
