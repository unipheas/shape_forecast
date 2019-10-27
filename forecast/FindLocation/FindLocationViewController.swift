//
//  FindLocationViewController.swift
//  forecast
//
//  Created by Jakob Vinther-Larsen on 19/02/2019.
//  Copyright © 2019 SHAPE A/S. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol FindLocationViewControllerOutput: class {
    func viewIsReady(at coordinate: CLLocationCoordinate2D)
    func locationSelected(at coordinate: CLLocationCoordinate2D)
}

final class FindLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    private lazy var mapView: MKMapView = MKMapView(frame: .zero)
    
    var output: FindLocationViewControllerOutput!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup location manager and request user permission
        locationManager.requestWhenInUseAuthorization();
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        else{
            // TODO: Display issue to user and ask for permission again
            print("Location service disabled");
        }
        
        view.addSubview(mapView)

        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(findLocation(_:)))
        gesture.delegate = self
        mapView.addGestureRecognizer(gesture)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // Convert CLLocation to CLLocationCoordinate2D
            let locationCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            // Update map annotation before view is ready
            updateMap(at: locationCoordinate)
            
            // Send location to view is ready for api call
            output.viewIsReady(at: locationCoordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: Display issue to user and ask for permission again
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    @objc
    private func findLocation(_ gesture: UITapGestureRecognizer) {
        
        // Gets coordinates from user touch gesture
        let point = gesture.location(in: mapView)
        let touchMapCoordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        // Update map annotation
        updateMap(at: touchMapCoordinate)
        
        // Sets coordinates for API call
        output.locationSelected(at: touchMapCoordinate)
    }
    
    func updateMap(at pin: CLLocationCoordinate2D) {
        // Clears previous selection made by user
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        
        // Places annotation on map
        let annotation = MKPointAnnotation()
        annotation.coordinate = pin
        mapView.addAnnotation(annotation)
        mapView.setCenter(pin, animated: true)
    }
    
}

extension FindLocationViewController: FindLocationPresenterOutput {
    func presentForecast(_ forecastView: UIView) {
        
        // Checks for previous view and deletes
        if mapView.subviews.count > 1 {
            let viewToRemove = mapView.subviews[mapView.subviews.count - 1]
            viewToRemove.removeFromSuperview()
        }
        
        // Adds background with blur effect to newly constructed view
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = mapView.frame
        effectView.translatesAutoresizingMaskIntoConstraints = false
        effectView.layer.cornerRadius = 5;
        effectView.layer.masksToBounds = true;
        mapView.addSubview(effectView)
        effectView.alpha = 0
        UIView.animate(withDuration: 2.0) { effectView.alpha = 0.8 }
        
        // Adds constructed view to map view
        mapView.addSubview(forecastView)
        
        // Sets constraints for new views
        NSLayoutConstraint.activate([
            effectView.topAnchor.constraint(equalTo: forecastView.layoutMarginsGuide.topAnchor),
            effectView.leadingAnchor.constraint(equalTo: forecastView.layoutMarginsGuide.leadingAnchor),
            effectView.trailingAnchor.constraint(equalTo: mapView.layoutMarginsGuide.trailingAnchor, constant: -100),
            effectView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

// Setup gesture recognizer to add new pins on map on each touch
extension FindLocationViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    return !(touch.view is MKPinAnnotationView)
  }
}
