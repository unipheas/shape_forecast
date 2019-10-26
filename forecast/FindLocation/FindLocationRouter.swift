
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

final class FindLocationRouter {
    let api: ForecastClient
    var output: FindLocationPresenter!
    
    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }
}

extension FindLocationRouter: FindLocationInteractorAction {
    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        
        api.perform(CurrentWeather.getCurrent(String(coordinate.latitude), String(coordinate.longitude)), completion: { result in
            
        })
    }
}
