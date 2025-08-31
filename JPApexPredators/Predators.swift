//
//  Predators.swift
//  JPApexPredators
//
//  Created by Usama Fouad on 29/08/2025.
//

import Foundation

class Predators {
    var apexPredators: [ApexPredator] = []
    var allApexPredators: [ApexPredator] = []
    
    init() {
        self.decodeApexPredatorsData()
    }
    
    func decodeApexPredatorsData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error decoding Json data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator] {
        if searchTerm.isEmpty {
            return apexPredators
        }
        
        return apexPredators.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort { predator1, predator2 in
            if alphabetical {
                predator1.name < predator2.name
            } else {
                predator1.id < predator2.id
            }
        }
    }
    
    func filter(by type: ApexPredator.APType) {
        if type == .all {
            apexPredators = allApexPredators
        } else {
            apexPredators = allApexPredators.filter { predator in
                predator.type == type
            }
        }
    }
    
    func filter(by movie: String) {
        if movie != "All Movies" {
            apexPredators = apexPredators.filter { $0.movies.contains(movie) }
        }
    }
}
