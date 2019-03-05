//
//  DataController.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 01/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import Foundation
import PromiseKit

class DataController {

    private let urlSession = URLSession.shared

    func getCurrentWeather(at latitude: Double, longitude: Double) -> Promise<WeatherResponse> {
        let urlString = API_URL + "weather?lat=" +
        "\(latitude)&lon=\(longitude)&appid=\(API_KEY)&units=metric"
        let url = URL(string: urlString)!

        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
            }.compactMap {
                return try JSONDecoder().decode(WeatherResponse.self, from: $0.data)
        }

    }

    func getForecast(at latitude: Double, longitude: Double) -> Promise<ForecastResponse> {
        let urlString = API_URL + "forecast?lat=" +
        "\(latitude)&lon=\(longitude)&appid=\(API_KEY)&units=metric"
        let url = URL(string: urlString)!

        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
            }.compactMap {
                return try JSONDecoder().decode(ForecastResponse.self, from: $0.data)
        }


    }

}
