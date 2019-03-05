//
//  WeatherCell.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 02/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet var conditionIconImageView: UIImageView!
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var conditionDescriptionLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var divider: UIView!
}
