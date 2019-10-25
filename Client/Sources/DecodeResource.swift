//
//  DecodeResource.swift
//  Client
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Foundation

public func decodeResource<E>(_ resource: E.Type) -> (Data) throws -> E where E: Decodable {
    return { data in
        let decoder = JSONDecoder()
        return try decoder.decode(resource, from: data)
    }
}
