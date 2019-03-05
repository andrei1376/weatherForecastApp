//
//  ForecastResponse.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 02/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import Foundation

struct ForecastResponse: Codable {
    let list: [WeatherResponse]
}
