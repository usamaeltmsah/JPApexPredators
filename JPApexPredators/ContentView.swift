//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Usama Fouad on 29/08/2025.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let predators = Predators()
    @State var searchText: String = ""
    @State var alphabetical: Bool = false
    @State var currentSelection = ApexPredator.APType.all
    @State var currentSelectedMovie = "All Movies"
    @State var allMovies = Set<String>()
    
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection)
        predators.filter(by: currentSelectedMovie)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinos) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator, position: .camera(
                        MapCamera(
                            centerCoordinate: predator.location,
                            distance: 3000
                        )))
                } label: {
                    HStack {
                        // Dinasour image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        VStack(alignment: .leading) {
                            // Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter", selection: $currentSelection) {
                            ForEach(ApexPredator.APType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                        Picker("Movie", selection: $currentSelectedMovie) {
                            ForEach(allMovies.sorted(by: <), id: \.self) { movie in
                                Text(movie)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            allMovies.insert("All Movies")
            predators.allApexPredators.forEach { predator in
                allMovies = allMovies.union(predator.movies)
            }
        }
    }
}

#Preview {
    ContentView()
}
