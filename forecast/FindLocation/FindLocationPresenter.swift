//
//  FindLocationPresenter.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

protocol FindLocationPresenterOutput: class {
}

final class FindLocationPresenter {
    weak var output: FindLocationPresenterOutput!
}

extension FindLocationPresenter: FindLocationInteractorOutput {
    
}
