//
//  AppDelegate.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit
import API

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let client = ForecastClient(appId: "9bca04561bc6c337ab4854b4ea35fd17")
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = FindLocationConfig.setup(api: client)
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        
        return true
    }

}
