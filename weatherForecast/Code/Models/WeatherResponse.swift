//
//  WeatherResponse.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 02/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let coord: Coord?
    let weather: [Weather]
    let main: WeatherMain
    let wind: Wind
    let rain: Rain?
    let dt: TimeInterval
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherMain: Codable {
    let temp: Double
    let pressure: Double?
    let humidity: Double?
}

struct Wind: Codable {
    let speed: Double?
    let deg: Double?
}

struct Rain: Codable {
    let lastHour: Double?
    let lastThreeHours: Double?

    private enum CodingKeys: String, CodingKey {
        case lastHour = "1h"
        case lastThreeHours = "3h"
    }
}

struct Coord: Codable {
    let lat: Double
    let lon: Double
}
