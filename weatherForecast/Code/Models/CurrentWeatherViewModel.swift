//
//  CurrentWeatherViewModel.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 05/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import Foundation

class CurrentWeatherViewModel {
    private let weatherInfo: WeatherResponse
    private let city: String?
    private let country: String?

    init(weatherInfo: WeatherResponse, city: String?, country: String?) {
        self.weatherInfo = weatherInfo
        self.city = city
        self.country = country
    }

    var location: String {
        guard let city = city, let country = country else {
            return ""
        }
        return city + ", " + country
    }
    
    var temperature: String {
        guard let condition = weatherInfo.weather.first?.main else {
            return ""
        }
        return Int(weatherInfo.main.temp).description + "ºC | " + condition
    }
    var iconImageName: String {
        guard let iconName = weatherInfo.weather.first?.iconImageName(forSize: .big) else {
            return ""
        }
        return iconName
    }

    var humidity: String? {
        guard let amount = weatherInfo.main.humidity else {
            return ""
        }
        return Int(amount).description + "%"
    }

    var precipitation: String? {
        guard let amount = weatherInfo.rain?.lastHour ?? weatherInfo.rain?.lastThreeHours else {
            return ""
        }
        return amount.description + " mm"
    }

    var pressure: String? {
        guard let amount = weatherInfo.main.pressure else {
            return ""
        }
        return amount.description + " hPa"
    }

    var windSpeed: String? {
        guard let amount = weatherInfo.wind.speed else {
            return ""
        }
        return amount.description + " km/h"
    }

    var direction: String? {
        guard let cardinalDirection = weatherInfo.wind.cardinalDirection else {
            return ""
        }
        return cardinalDirection.rawValue
    }

    var shareableText: String {
        guard let city = city else {
            return "The temperature is \(temperature)!"
        }
        return "I'm at \(city) and the temperature here is \(Int(weatherInfo.main.temp).description)ºC!"
    }

}
