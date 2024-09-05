//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Daniyal Mohammed on 2024-09-04.
//

import Foundation

struct PokemonDetail: Codable {
    struct Sprites: Codable {
        let frontDefault: String
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
    let sprites: Sprites
}
