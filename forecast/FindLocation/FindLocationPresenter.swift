//
//  FindLocationPresenter.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation
import Client
import Entities

protocol FindLocationPresenterOutput: class {
    func presentForecast(_ forecastView: UIView)
}

final class FindLocationPresenter {
    weak var output: FindLocationPresenterOutput!
    
}

extension FindLocationPresenter: FindLocationInteractorOutput {
    func setupForecast(for result: Result<CurrentWeather, Client.Error>) {
        if let result = result.value {
            DispatchQueue.main.async {
                let forecastView = UIView()
                
                // Setup for city and country names
                let cityLabel = UILabel()
                cityLabel.translatesAutoresizingMaskIntoConstraints = false
                cityLabel.textAlignment = .left
                cityLabel.text = "\(result.city.name), \(result.city.country)"
                cityLabel.font = UIFont.systemFont(ofSize: 20)
                forecastView.addSubview(cityLabel)
                
                // Setup for temperature
                var temperature = Measurement(value: result.list[0].main.temp, unit: UnitTemperature.kelvin)
                let usesMetricSystem = NSLocale.current.usesMetricSystem
                if usesMetricSystem {
                    temperature = temperature.converted(to: UnitTemperature.celsius)
                } else {
                    temperature = temperature.converted(to: UnitTemperature.fahrenheit)
                }
                
                let finalMeasurement = MeasurementFormatter()
                finalMeasurement.unitOptions = .providedUnit
                let temp = finalMeasurement.string(from: temperature)
                
                let tempLabel = UILabel()
                tempLabel.translatesAutoresizingMaskIntoConstraints = false
                tempLabel.textAlignment = .left
                tempLabel.text = "Temp is \(temp)"
                tempLabel.font = UIFont.systemFont(ofSize: 16)
                forecastView.addSubview(tempLabel)
                
                // Setup for humidity
                let formatter = NumberFormatter()
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 2
                formatter.numberStyle = .decimal
                
                let humidityLabel = UILabel()
                humidityLabel.translatesAutoresizingMaskIntoConstraints = false
                humidityLabel.textAlignment = .left
                humidityLabel.text = "Humidity is \(formatter.string(from: result.list[0].main.humidity as NSNumber) ?? "n/a")%"
                humidityLabel.font = UIFont.systemFont(ofSize: 16)
                forecastView.addSubview(humidityLabel)
                
                // Setup for weather
                let weatherLabel = UILabel()
                weatherLabel.translatesAutoresizingMaskIntoConstraints = false
                weatherLabel.textAlignment = .left
                weatherLabel.text = "Today is \(result.list[0].weather[0].description)"
                weatherLabel.font = UIFont.systemFont(ofSize: 16)
                forecastView.addSubview(weatherLabel)
                
                // Sets constraints for all subviews
                NSLayoutConstraint.activate([
                    cityLabel.topAnchor.constraint(equalTo: forecastView.layoutMarginsGuide.topAnchor),
                    cityLabel.leadingAnchor.constraint(equalTo: forecastView.layoutMarginsGuide.leadingAnchor, constant: 5),
                    tempLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
                    tempLabel.leadingAnchor.constraint(equalTo: forecastView.leadingAnchor, constant: 15),
                    humidityLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5),
                    humidityLabel.leadingAnchor.constraint(equalTo: forecastView.leadingAnchor, constant: 15),
                    weatherLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 5),
                    weatherLabel.leadingAnchor.constraint(equalTo: forecastView.leadingAnchor, constant: 15),
                ])
                
                // Sends constructed view to view controller
                self.output.presentForecast(forecastView)
            }
        } else {
            // TODO: Display error to user
        }
    }
}
