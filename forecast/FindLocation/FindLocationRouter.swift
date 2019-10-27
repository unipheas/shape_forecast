
//
//  FindLocationRouter.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import MapKit
import API
import Entities
import Client

protocol FindLocationRouterOutput: class {
    func sendResultsToInteractor(for results: Result<CurrentWeather, Client.Error>)
}

final class FindLocationRouter {
    let api: ForecastClient
    var output: FindLocationRouterOutput!
    
    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }
}

extension FindLocationRouter: FindLocationInteractorAction {
    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        
        api.perform(CurrentWeather.getCurrent(String(coordinate.latitude), String(coordinate.longitude)), completion: { result in
            self.output.sendResultsToInteractor(for: result)
        })
    }
}

