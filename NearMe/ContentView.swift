//
//  ContentView.swift
//  NearMe
//
//  Created by Muktita Kim on 5/3/23.
//

//import SwiftUI
//import MapKit
//
//enum DisplayType {
//    case map
//    case list
//}
//
//struct ContentView: View {
//
//    @StateObject private var placeListVM = PlaceListViewModel()
//    @State private var userTrackingMode: MapUserTrackingMode = .follow
//    @State private var searchTerm: String = ""
//    @State private var displayType: DisplayType = .map
//    @State private var isDragged: Bool = false
//    @State private var favoriteGyms: [(name: String, address: String)] = []
//    @State private var showingFavoriteView = false
//    private func getRegion() -> Binding<MKCoordinateRegion> {
//
//        guard let coordinate = placeListVM.currentLocation else {
//            return .constant(MKCoordinateRegion.defaultRegion)
//        }
//
//        return .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
//
//    }
//
//    var body: some View {
//        VStack {
//
//            TextField("Search", text: $searchTerm, onEditingChanged: { _ in
//
//            }, onCommit: {
//                    // get all landmarks
//                placeListVM.searchLandmarks(searchTerm: searchTerm)
//
//            }).textFieldStyle(RoundedBorderTextFieldStyle())
//
//            LandmarkCategoryView { (category) in
//                placeListVM.searchLandmarks(searchTerm: category)
//            }
//
//            Picker("Select", selection: $displayType) {
//                Text("Map").tag(DisplayType.map)
//                Text("List").tag(DisplayType.list)
//            }.pickerStyle(SegmentedPickerStyle())
//
//            if displayType == .map {
//
//                Map(coordinateRegion: getRegion(), interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: placeListVM.landmarks) { landmark in
//                    MapMarker(coordinate: landmark.coordinate)
//                }
//                .gesture(DragGesture()
//                            .onChanged({ (value) in
//                                isDragged = true
//                            })
//                ).overlay(isDragged ? AnyView(RecenterButton {
//                    placeListVM.startUpdatingLocation()
//                    isDragged = false
//                }.padding()): AnyView(EmptyView()), alignment: .bottom)
//
//
//            } else if displayType == .list {
//                LandmarkListView(landmarks: placeListVM.landmarks)
//            }
//
//            Button(action: {
//                showingFavoriteView = true
//            }, label: {
//                Text("Favorite Gyms")
//            })
//            .sheet(isPresented: $showingFavoriteView) {
//                FavoriteView(favoriteGyms: $favoriteGyms, showView: $showingFavoriteView)
//            }
//
//
//        }.padding()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//Footer

import SwiftUI
import MapKit

enum DisplayType {
    case map
    case list
}

struct ContentView: View {
    
    // StateObject to manage the list of landmarks
    @StateObject private var placeListVM = PlaceListViewModel()
    
    // State variables to manage the map
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var searchTerm: String = ""
    @State private var displayType: DisplayType = .map
    @State private var isDragged: Bool = false
    
    // State variable to track whether the favorite view is being shown or not
    @State private var favoriteGyms: [(name: String, address: String)] = []
    @State private var showingFavoriteView = false
    
    // Function to get the current location and set the map's region
    private func getRegion() -> Binding<MKCoordinateRegion> {
        // Check if we have a current location
        guard let coordinate = placeListVM.currentLocation else {
            return .constant(MKCoordinateRegion.defaultRegion)
        }
        // Set the map's region based on the current location
        return .constant(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        
    }
    
    // The body of the view
    var body: some View {
        VStack {
            
            // Search bar to search for landmarks
            TextField("Search", text: $searchTerm, onEditingChanged: { _ in
                
            }, onCommit: {
                    // get all landmarks
                placeListVM.searchLandmarks(searchTerm: searchTerm)
                
            }).textFieldStyle(RoundedBorderTextFieldStyle())
            // View to filter landmarks by category
            LandmarkCategoryView { (category) in
                placeListVM.searchLandmarks(searchTerm: category)
            }
            
            // Segmented control to switch between the map and list view
            Picker("Select", selection: $displayType) {
                Text("Map").tag(DisplayType.map)
                Text("List").tag(DisplayType.list)
            }.pickerStyle(SegmentedPickerStyle())
            
            
            // Either a map or a list of landmarks
            if displayType == .map {
                
                Map(coordinateRegion: getRegion(), interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode, annotationItems: placeListVM.landmarks) { landmark in
                    MapMarker(coordinate: landmark.coordinate)
                }
                .gesture(DragGesture()
                            .onChanged({ (value) in
                                isDragged = true
                            })
                ).overlay(isDragged ? AnyView(RecenterButton {
                    placeListVM.startUpdatingLocation()
                    isDragged = false
                }.padding()): AnyView(EmptyView()), alignment: .bottom)
                
                
            } else if displayType == .list {
                LandmarkListView(landmarks: placeListVM.landmarks)
            }
            
            Button(action: {
                         showingFavoriteView = true
                       }, label: {
                            Text("Favorite Gyms")
                        })
            .sheet(isPresented: $showingFavoriteView) {
                FavoriteView(favoriteGyms: $favoriteGyms, showView: $showingFavoriteView)
            }
        }
        .padding()
    }
}

// Preview struct for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
