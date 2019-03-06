//
//  weatherForecastUITests.swift
//  weatherForecastUITests
//
//  Created by Emiliano Baublys on 01/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import XCTest

class weatherForecastUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {

        app = XCUIApplication()
        app.launch()

        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSwitchToOtherPage() {

        let forecastButton = app.tabBars.buttons["Forecast"]
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
