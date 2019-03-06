//
//  weatherForecastTests.swift
//  weatherForecastTests
//
//  Created by Emiliano Baublys on 01/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import XCTest
@testable import weatherForecast

class weatherForecastTests: XCTestCase {

    var weatherResponseTest: WeatherResponse!

    var forecastResponseTest: ForecastResponse!

    var currentWeatherModelTest: CurrentWeatherViewModel!

    var forecastCellModelTest: ForecastCellViewModel!

    var sessionUnderTest: URLSession!


    override func setUp() {
        weatherResponseTest = .init(coord: Coord(lat: 50, lon: 50), weather: [Weather(id: 01, main: "Cloudy", description: "Its very cloudy", icon: "01n")], main: WeatherMain(temp: 10, pressure: 10, humidity: 10), wind: Wind(speed: 10, deg: 10), rain: Rain(lastHour: 20, lastThreeHours: nil), dt: 123123)

        currentWeatherModelTest = CurrentWeatherViewModel(weatherInfo: weatherResponseTest, city: "Buenos Aires", country: "Argentina")

        forecastResponseTest = ForecastResponse(list: [weatherResponseTest])

        forecastCellModelTest = ForecastCellViewModel(image: (forecastResponseTest.list.first?.weather.first)!, condition: "Sunny", hour: 123123, conditionDetail: "Very sunny", temperature: 10)

        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)

    }

    override func tearDown() {
        weatherResponseTest = nil
        forecastResponseTest = nil
        currentWeatherModelTest = nil
        forecastCellModelTest = nil
        sessionUnderTest = nil
    }

    func testCurrentWeatherModel() {
        let location = currentWeatherModelTest.location
        XCTAssertEqual(location, "Buenos Aires, Argentina", "Wrong!")

        let temperature = currentWeatherModelTest.temperature
        XCTAssertEqual(temperature, "10ºC | Cloudy", "Wrong!")

        let iconImage = currentWeatherModelTest.iconImageName
        XCTAssertEqual(iconImage, "Clear Sky (Night)", "Wrong!")

        let humidity = currentWeatherModelTest.humidity
        XCTAssertEqual(humidity, "10%", "Wrong!")

        let precipitation = currentWeatherModelTest.precipitation
        XCTAssertEqual(precipitation, "20.0 mm", "Wrong!")

        let pressure = currentWeatherModelTest.pressure
        XCTAssertEqual(pressure, "10.0 hPa", "Wrong!")

        let windSpeed = currentWeatherModelTest.windSpeed
        XCTAssertEqual(windSpeed, "10.0 km/h", "Wrong!")

        let direction = currentWeatherModelTest.direction
        XCTAssertEqual(direction, "N", "Wrong!")

        let shareableText = currentWeatherModelTest.shareableText
        XCTAssertEqual(shareableText, "I'm at Buenos Aires and the temperature here is 10ºC!", "Wrong!")

    }

    func testForecastViewModel() {
        

    }

    func testValidApiCall() {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=37&lon=55&appid=4e5da8d65399e1a9dbcd1599d2f01442")
        let promise = expectation(description: "Status code: 200")

        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }

}
