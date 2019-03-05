//
//  BaseTabBarController.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 03/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import UIKit
import PromiseKit
import CoreLocation

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }

    private func setupStyle() {
        let fontAttributes = [NSAttributedString.Key.font: UIFont.montserrat(of: .semibold, withSize: .verySmall)]
        UITabBarItem.appearance().setTitleTextAttributes(fontAttributes, for: .normal)
    }

}
