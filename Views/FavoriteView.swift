//
//  FavoriteView.swift
//  NearMe
//
//  Created by Muktita Kim on 5/3/23.
//
import SwiftUI

struct FavoriteView: View {
    
    // Properties that are passed in as bindings
    @Binding var favoriteGyms: [(name: String, address: String)]
    @Binding var showView: Bool
    
    // State properties for the view
    @State private var gymName: String = ""
    @State private var gymAddress: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Your Favorite Gym")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button("Done") {
                    showView = false
                }
            }
            .padding()
            
            // A vertical stack
            VStack {
                // A horizontal stack containing two text fields for entering the gym name and address
                HStack {
                    TextField("Name", text: $gymName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("Address", text: $gymAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                
                // A button for adding a new gym to the list of favorites
                Button("Add") {
                    favoriteGyms.append((name: gymName, address: gymAddress))
                    gymName = ""
                    gymAddress = ""
                }
                .padding()
                
                // A list of favorite gyms
                List {
                    ForEach(favoriteGyms, id: \.name) { gym in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(gym.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8.0)
                            
                            VStack(alignment: .leading) {
                                Text(gym.address)
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8.0)
                        }
                        // Delete button
                        .contextMenu {
                            Button("Delete") {
                                if let index = favoriteGyms.firstIndex(where: { $0.name == gym.name && $0.address == gym.address }) {
                                    favoriteGyms.remove(at: index)
                                }
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        favoriteGyms.remove(atOffsets: offsets)
    }
}
