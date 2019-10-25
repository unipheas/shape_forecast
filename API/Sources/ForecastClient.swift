//
//  ForecastClient.swift
//  API
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import Client

public final class ForecastClient: Client {
    private let authParameters: QueryParameters
    public init(appId: String) {
        self.authParameters = QueryParameters([URLQueryItem(name: "APPID", value: appId)])
        super.init(baseURL: URL(string: "https://api.openweathermap.org/data/2.5/")!)
    }
    
    public override func prepare<T, E>(request: Request<T, E>) -> Request<T, E> {
        var request = request
        if request.needsAuthorization {
            request.parameters.append(authParameters)
        }
        return request
    }
    
    public override func perform<Resource, Error>(_ request: Request<Resource, Error>, completion: @escaping (Result<Resource, Client.Error>) -> Void) -> URLSessionTask {
        return super.perform(request, completion: completion)
    }
}
