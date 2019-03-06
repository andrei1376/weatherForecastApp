//
//  FirstViewController.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 01/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import UIKit
import PromiseKit
import CoreLocation
import Reachability

class TodayWeatherViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var currentWeatherLocationLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!

    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var humidityStack: UIStackView!

    @IBOutlet weak var precipitationStack: UIStackView!
    @IBOutlet weak var precipitationLabel: UILabel!

    @IBOutlet weak var pressureStack: UIStackView!
    @IBOutlet weak var pressureLabel: UILabel!

    @IBOutlet weak var windStack: UIStackView!
    @IBOutlet weak var windLabel: UILabel!

    @IBOutlet weak var windDirectionStack: UIStackView!
    @IBOutlet weak var windDirectionLabel: UILabel!

    @IBOutlet var stateView: StateView!

    // MARK: - Internal Properties

    let dataController = DataController()
    let locationHelper = LocationHelper()
    var shareable: String = ""

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stateView.show(for: .loading, toView: self.view)
        getCurrentLocation()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ReachabilityManager.shared.addListener(listener: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ReachabilityManager.shared.addListener(listener: self)
    }

    // MARK: - Actions

    private func getCurrentLocation() {
        locationHelper.getLocation()
            .done { [weak self] placemark in
                self?.handleLocation(placemark: placemark)
            }
            .catch { [weak self] error in
                guard self != nil else { return }
                self?.present(error: error, retryAction: { (_) in
                    self?.getCurrentLocation()
                    self?.stateView.show(for: .loading, toView: self!.view)
                }, cancelAction: { (_) in
                    if ReachabilityManager.shared.isNetworkAvailable {
                        self?.stateView.show(for: .empty, toView: self!.view)
                    }else{
                        self?.stateView.show(for: .noInternet, toView: self!.view)
                    }

                })
        }
    }

    private func handleLocation(placemark: CLPlacemark) {
        let coordinate = placemark.location!.coordinate
        dataController.getCurrentWeather(at: coordinate.latitude, longitude: coordinate.longitude)
            .then { [weak self] weatherInfo -> Promise<ForecastResponse> in
                let currentWeather = CurrentWeatherViewModel(weatherInfo: weatherInfo, city: placemark.locality, country: placemark.country)
                self?.shareable = currentWeather.shareableText
                self?.updateUI(with: currentWeather)

                return (self?.dataController.getForecast(at: coordinate.latitude, longitude: coordinate.longitude))!
            }.done { [weak self] forecastInfo in
                self?.handleForecast(data: forecastInfo, city: placemark.locality!)
                self?.stateView.hide()
            }.catch { [weak self] error in
                self?.present(error: error)
                self?.stateView?.hide()
            }
    }

    func handleForecast(data: ForecastResponse, city: String){
        guard let viewcontrollers = tabBarController?.viewControllers else {return}
        for viewController in viewcontrollers {
            if let vc = viewController as? ForecastViewController {
                vc.forecastData = data
                vc.city = city
            }
        }
    }


    private func updateUI(with info: CurrentWeatherViewModel) {
        self.currentWeatherLocationLabel.text = info.location
        self.currentTemperatureLabel.text = info.temperature
        self.currentWeatherImageView.image = UIImage(named: info.iconImageName)


        if info.humidity != "" {
            self.humidityLabel.text = info.humidity
        }else{
            humidityStack.isHidden = true
        }

        if info.precipitation != "" {
            self.precipitationLabel.text = info.precipitation
        }else{
            precipitationStack.isHidden = true
        }

        if info.pressure != "" {
            self.pressureLabel.text = info.pressure
        }else{
            pressureStack.isHidden = true
        }

        if info.windSpeed != "" {
            self.windLabel.text = info.windSpeed
        }else{
            windStack.isHidden = true
        }

        if info.direction != "" {
            self.windDirectionLabel.text = info.direction
        }else{
            windDirectionStack.isHidden = true
        }

    }

    // MARK: - IBActions

    @IBAction func shareTapped(_ sender: Any) {
        let items = ["Hey! \(shareable)"]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
}

extension TodayWeatherViewController: NetworkStatusListener {

    func networkStatusDidChange(status: Reachability.Connection) {
        switch status {
        case .none:
            stateView.show(for: .noInternet, toView: self.view)
        default:
            getCurrentLocation()
        }
    }

}

