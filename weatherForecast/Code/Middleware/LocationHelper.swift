//
//  LocationHelper.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 02/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import Foundation
import CoreLocation
import PromiseKit

class LocationHelper {
    let coder = CLGeocoder()

    func getLocation() -> Promise<CLPlacemark> {
        return CLLocationManager.requestLocation().lastValue.then {
            location in
            return self.coder.reverseGeocode(location: location).firstValue
        }
    }

}
