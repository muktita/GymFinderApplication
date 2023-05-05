//
//  LocationManager.swift
//  NearMe
//
//  Created by Muktita Kim on 5/3/23.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject {
    
    // The CLLocationManager instance that handles location updates
    private let locationManager = CLLocationManager()
    
    // Published variable to hold the user's current location
    @Published var location: CLLocation? = nil
    
    override init() {
        super.init()
        // Set the locationManager delegate to self
        locationManager.delegate = self
        
        // Set the desired accuracy and distance filter
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        // Request authorization to use the user's location
        locationManager.requestWhenInUseAuthorization()
        // Start updating the location
        locationManager.startUpdatingLocation()
    }
    
    // Function to stop updating the user's location
    func stopUpdates() {
        locationManager.stopUpdatingLocation()
    }
    
    // Function to start updating the user's location
    func startUpdates() {
        locationManager.startUpdatingLocation()
    }
    
}

// Extension that conforms to CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        DispatchQueue.main.async {
            self.location = location
        }
    }
    
}
