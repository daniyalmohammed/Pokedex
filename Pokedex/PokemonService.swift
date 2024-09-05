//
//  PokemonService.swift
//  Pokedex
//
//  Created by Daniyal Mohammed on 2024-09-04.
//

import Foundation

class PokemonService: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    private let baseURL = "https://pokeapi.co/api/v2/pokemon"
    private var offset = 0
    private var isLoading = false
    private let limit = 20
    
    func fetchPokemons() {
        guard !isLoading else { return }
        isLoading = true
        
        guard let url = URL(string: "\(baseURL)?limit=\(limit)&offset=\(offset)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.pokemons.append(contentsOf: decodedResponse.results)
                        self.offset += self.limit
                        self.isLoading = false
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                    self.isLoading = false
                }
            }
        }.resume()
    }
}
