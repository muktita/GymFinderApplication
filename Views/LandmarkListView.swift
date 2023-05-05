//
//  LandmarkListView.swift
//  NearMe
//
//  Created by Muktita Kim on 5/3/23.
//

import SwiftUI

//import SwiftUI

//import SwiftUI

struct LandmarkListView: View {
    // An array of landmark view models to display in the list
    let landmarks: [LandmarkViewModel]
    
    var body: some View {
        // A List view that displays the landmarks
        List(landmarks, id: \.id) { landmark in
            // A vertical stack of text views that display the landmark's name and title
            VStack(alignment: .leading, spacing: 10) {
                Text(landmark.name)
                    .font(.headline)
                Text(landmark.title)
            }
        }
    }
}
