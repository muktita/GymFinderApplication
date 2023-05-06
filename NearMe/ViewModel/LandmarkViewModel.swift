//
//  LandmarkViewModel.swift
//  NearMe
//
//  Created by Muktita Kim on 5/3/23.
//

import Foundation
import MapKit

struct LandmarkViewModel: Identifiable {
    
    // The landmark's placemark
    let placemark: MKPlacemark
    
    // The landmark's ID
    let id = UUID()
    
    // Get the landmark's name
    var name: String {
        placemark.name ?? ""
    }
    // Get the landmark's title
    var title: String {
        placemark.title ?? ""
    }
    
    // get the landmark's coordinate
    var coordinate: CLLocationCoordinate2D {
        placemark.coordinate
    }
    
    
    
}
