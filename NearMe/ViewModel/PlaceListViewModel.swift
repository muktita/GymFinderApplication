//
//  PlaceListViewModel.swift
//  NearMe
//
//  Created by Muktita Kim on 5/3/23.
//

import Foundation
import Combine
import MapKit

class PlaceListViewModel: ObservableObject {
    
    // LocationManager manages the user's location
    private let locationManager: LocationManager
    
    // Combine cancellable to observe changes in the user's location
    var cancellable: AnyCancellable?
    
    // Published variable to hold the user's current location
    @Published var currentLocation: CLLocationCoordinate2D?
    
    // Published variable to hold an array of landmark view models
    @Published var landmarks: [LandmarkViewModel] = []
    
    init() {
        
        // Initialize the locationManager
        locationManager = LocationManager()
        
        // Observe changes in the user's locatio
        cancellable = locationManager.$location.sink { (location) in
            if let location = location {
                DispatchQueue.main.async {
                    // Update the currentLocation variable
                    self.currentLocation = location.coordinate
                    // Stop updating the location
                    self.locationManager.stopUpdates()
                }
            }
        }
    }
    
    // Function to start updating the user's location
    func startUpdatingLocation() {
           locationManager.startUpdates()
    }
    
    // Function to search for landmarks based on the given search term
    func searchLandmarks(searchTerm: String) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTerm
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let error = error {
                print(error)
            } else if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    return LandmarkViewModel(placemark: $0.placemark)
                }
            }
        }
        
    }
    
}
