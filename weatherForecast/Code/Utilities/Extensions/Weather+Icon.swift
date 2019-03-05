//
//  Weather+Icon.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 02/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import Foundation

extension Weather {
    enum IconSize {
        case small
        case big
    }
    enum IconType: String {
        case brokenClouds = "04"
        case clearSky = "01"
        case fewClouds = "02"
        case mist = "50"
        case rain = "10"
        case scatteredClouds = "03"
        case showerRain = "09"
        case snow = "13"
        case thunderstorm = "11"

        var name: String {
            switch self {
            case .brokenClouds:
                return "Broken Clouds"
            case .clearSky:
                return "Clear Sky"
            case .fewClouds:
                return "Few Clouds"
            case .mist:
                return "Mist"
            case .rain:
                return "Rain"
            case .scatteredClouds:
                return "Scattered Clouds"
            case .showerRain:
                return "Shower Rain"
            case .snow:
                return "Snow"
            case .thunderstorm:
                return "Thunderstorm"
            }
        }

    }

    func iconImageName(forSize size: IconSize) -> String {
        guard let iconType = IconType(rawValue: String(icon.dropLast())) else {
            return ""
        }

        let dayOrNight = icon.last == "d" ? "(Day)" : "(Night)"
        let sizeString = size == .small ? " small" : ""

        return iconType.name + " " + dayOrNight + "" + sizeString
    }
}
