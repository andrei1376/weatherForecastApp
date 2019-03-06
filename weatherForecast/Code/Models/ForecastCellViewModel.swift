//
//  ForecastCellViewModel.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 04/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import Foundation

struct ForecastCellViewModel {
    let image: Weather
    let condition: String
    let hour: TimeInterval
    let conditionDetail: String
    let temperature: Double
}

struct ForecastSection {
    let section: Int
    let forecastData: [ForecastCellViewModel]
}
