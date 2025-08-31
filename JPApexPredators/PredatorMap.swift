//
//  PredatorMap.swift
//  JPApexPredators
//
//  Created by Usama Fouad on 30/08/2025.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators()
    @State var position: MapCameraPosition
    @State var satallite = false
    @State var selectedPredator: ApexPredator?
    @State var showAnnotationInfo = false
    
    var body: some View {
        
        GeometryReader { geo in
            Map(position: $position) {
                ForEach(predators.apexPredators) { predator in
                    Annotation(predator.name, coordinate: predator.location) {
                        ZStack {
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .shadow(color: .white, radius: 3)
                                .scaleEffect(x: -1)
                                .onTapGesture {
                                    withAnimation {
                                        selectedPredator = predator
                                        showAnnotationInfo.toggle()
                                    }
                                }
                            
                            if showAnnotationInfo && selectedPredator?.id == predator.id {
                                ZStack {
                                    Color.black
                                    VStack(alignment: .trailing, spacing: 4) {
                                        Button {
                                            withAnimation {
                                                showAnnotationInfo.toggle()
                                            }
                                        } label: {
                                            Image(systemName: "xmark.circle")
                                                .font(.largeTitle)
                                        }
                                        .padding(.top)
                                        .padding(.trailing)
                                        Text(predator.name)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.white)
                                            .padding()
                                            .frame(alignment: .center)
                                    }
                                }
                                .clipShape(.rect(cornerRadius: 10))
                            }
                        }
                    }
                }
            }
            .mapStyle(satallite ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
            .overlay(alignment: .bottomTrailing) {
                Button {
                    satallite.toggle()
                } label: {
                    Image(systemName: satallite ? "globe.americas.fill" : "globe.americas")
                        .font(.largeTitle)
                        .imageScale(.large)
                        .padding(3)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 7))
                        .shadow(radius: 3)
                        .padding()
                }
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(position: .camera(
        MapCamera(
            centerCoordinate: Predators().apexPredators[2].location,
            distance: 1000,
            heading: 250,
            pitch: 80
        )))
    .preferredColorScheme(.dark)
}
