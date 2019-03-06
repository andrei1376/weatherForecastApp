//
//  SecondViewController.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 01/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barTitle: UINavigationItem!
    @IBOutlet var stateView: StateView!

    // MARK: - Internal Properties

    var forecast = [ForecastCellViewModel]()
    var forecastSections = [ForecastSection]()
    var city: String = "Location"

    let dataController = DataController()
    let locationHelper = LocationHelper()
    var forecastData: ForecastResponse?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let data = forecastData else {
            stateView.show(for: .empty, toView: self.view)
            return
        }
        setupSections(withForecast: data.list)
    }

    // MARK: - Actions
    private func setupSections(withForecast data:[WeatherResponse]) {
        let groupedItems = Dictionary(grouping: data.map {
            ForecastCellViewModel(image: ($0.weather.first)!, condition: ($0.weather.first?.main)!, hour: $0.dt, conditionDetail: ($0.weather.first?.description)!, temperature: $0.main.temp)
            }, by: { (item) -> Int in
                let date = Date(timeIntervalSince1970: item.hour)
                return Calendar.current.component(.day, from: date)
        })
        forecastSections = groupedItems.sorted(by: {
            return $0.key < $1.key
        }).enumerated().map( {
            return ForecastSection(section: $0.offset, forecastData: $0.element.value)
        })
    }

}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastSections[section].forecastData.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.forecastSections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else { fatalError() }

        let data = self.forecastSections[indexPath.section].forecastData[indexPath.row]
        barTitle.title = city
        cell.conditionDescriptionLabel.text = data.conditionDetail
        cell.conditionIconImageView.image = UIImage(named: data.image.iconImageName(forSize: .small))
        cell.temperatureLabel.text = Int(data.temperature).description + "º"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:00"
        cell.hourLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: data.hour))

        cell.divider.isHidden = self.forecastSections[indexPath.section].forecastData.count - 1 == indexPath.row

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell: HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        let title = titleForHeaderInSection(section)
        cell.titleLabel.text = title
        return cell
    }

    private func titleForHeaderInSection(_ section: Int) -> String? {
        var title: String? = "Today"
        if section != 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            title = dateFormatter.string(from: Date(timeIntervalSince1970: (self.forecastSections[section].forecastData.first?.hour)!))
        }

        return title?.uppercased()
    }

}

