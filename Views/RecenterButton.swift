//
//  RecenterButton.swift
//  NearMe
//
//  Created by Muktita Kim on 5/3/23.
//

import SwiftUI

struct RecenterButton: View {
    
    // A callback function to be executed when the button is tapped
    let onTapped: () -> ()
    
    var body: some View {
        // A button to recenter the user location
        Button(action: onTapped, label: {
            Label("Re-center", systemImage: "triangle")
        }).padding(10)
        .foregroundColor(.white)
        .background(Color(#colorLiteral(red: 0.202427417, green: 0.5955722928, blue: 0.8584871888, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
    }
}

struct RecenterButton_Previews: PreviewProvider {
    static var previews: some View {
        RecenterButton(onTapped: {})
    }
}
