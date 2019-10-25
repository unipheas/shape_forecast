//
//  APIError.swift
//  Client
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public struct APIError: Swift.Error {
    let errorData: Data
    public init(_ data: Data) {
        errorData = data
    }
}
