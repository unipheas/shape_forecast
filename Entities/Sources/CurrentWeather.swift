//
//  CurrentWeather.swift
//  Entities
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public struct CurrentWeather: Codable {
    enum CodingKeys: String, CodingKey {
        case city
        case list
    }
    
    public let city: City
    public let list: [List]
    
}

public struct City: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case country
    }
    
    public let name: String
    public let country: String
}

public struct List: Codable {
    enum CodingKeys: String, CodingKey {
        case main
        case weather
    }

    public let main: Main
    public let weather: [Weather]
}

public struct Main: Codable {
    enum CodingKeys: String, CodingKey {
        case temp
        case humidity
    }

    public let temp: Double
    public let humidity: Double
}

public struct Weather: Codable {
    enum CodingKeys: String, CodingKey {
        case main
        case description
        case icon
    }

    public let main: String
    public let description: String
    public let icon: String
}
