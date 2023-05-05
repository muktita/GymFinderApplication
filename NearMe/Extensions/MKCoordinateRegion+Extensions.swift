//
//  MKCoordinateRegion+Extensions.swift
//  NearMe
//
//  Created by Muktita Kim on 5/3/23.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    
    static var defaultRegion: MKCoordinateRegion {
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.8828, longitude: -117.8863), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
}
