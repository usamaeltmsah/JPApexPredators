//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Usama Fouad on 29/08/2025.
//

import SwiftUI

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: APType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
    
    enum APType: String, Decodable, CaseIterable, Identifiable {
        case all
        case land
        case air
        case sea
        
        var id: APType { self }
        
        var background: Color {
            switch self {
            case .all:
                    .clear
            case .land:
                    .brown
            case .air:
                    .teal
            case .sea:
                    .blue
            }
        }
        
        var icon: String {
            switch self {
            case .all:
                "square.stack.3d.up.fill"
            case .land:
                "leaf.fill"
            case .air:
                "wind"
            case .sea:
                "drop.fill"
            }
        }
    }
}
