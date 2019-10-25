//
//  FindLocationConfig.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit
import API

struct FindLocationConfig {
    static func setup(api apiClient: ForecastClient) -> UIViewController {
        let viewController = FindLocationViewController()
        let interactor = FindLocationInteractor(api: apiClient)
        let presenter = FindLocationPresenter()
        let router = FindLocationRouter(api: apiClient)
        
        viewController.output = interactor
        interactor.action = router
        interactor.output = presenter
        presenter.output = viewController
        
        return viewController
    }
}
