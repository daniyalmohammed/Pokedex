//
//  Pokemon.swift
//  Pokedex
//
//  Created by Daniyal Mohammed on 2024-09-04.
//

import Foundation

struct PokemonListResponse: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable {
    let name: String
    let url: String
    
    var id: Int {
        if let idString = url.split(separator: "/").last {
            return Int(idString) ?? 0
        }
        return 0
    }
}
