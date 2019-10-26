//
//  FindLocationInteractor.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import MapKit
import API
import Entities
import CoreLocation

protocol FindLocationInteractorOutput: class {
}

protocol FindLocationInteractorAction: class {
    func locationSelected(at coordinate: CLLocationCoordinate2D)
}


final class FindLocationInteractor {
    var output: FindLocationInteractorOutput!
    var action: FindLocationInteractorAction!
    
    let api: ForecastClient
    
    init(api apiClient: ForecastClient) {
        self.api = apiClient
    }
}

extension FindLocationInteractor: FindLocationViewControllerOutput {
    func viewIsReady(at coordinate: CLLocationCoordinate2D) {
        action.locationSelected(at: coordinate)
    }
    
    func locationSelected(at coordinate: CLLocationCoordinate2D) {
        action.locationSelected(at: coordinate)
    }
}
