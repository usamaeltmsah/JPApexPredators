//
//  Predators.swift
//  JPApexPredators
//
//  Created by Usama Fouad on 29/08/2025.
//

import Foundation

class Predators {
    var apexPredators: [ApexPredator] = []
    
    init() {
        self.decodeApexPredatorsData()
    }
    
    func decodeApexPredatorsData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                apexPredators = try decoder.decode([ApexPredator].self, from: data)
            } catch {
                print("Error decoding Json data: \(error)")
            }
        }
    }
}
