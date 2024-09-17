//
//  ContentView.swift
//  Pokedex
//
//  Created by Daniyal Mohammed on 2024-09-04.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var service = PokemonService()
    @State private var selectedPokemonImageURL: String? = nil
    @State private var selectedPokemonName: String? = nil

    let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]

    var body: some View {
        ZStack {
            Color(.systemYellow)
                .ignoresSafeArea()

            VStack {
                Text("Pokédex")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.top, 20)

                if let imageUrl = selectedPokemonImageURL, let pokemonName = selectedPokemonName {
                    VStack {
                        AsyncImage(url: URL(string: imageUrl)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 200, height: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(radius: 10)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        Text(pokemonName.capitalized)
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.bottom, 5)
                    }
                    .padding()
                    .background(Color.red.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.top, 10)
                }

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(service.pokemons) { pokemon in
                            Button(action: {
                                fetchPokemonDetails(for: pokemon)
                            }) {
                                VStack {
                                    CachedImageView(imageUrl: getPokemonImageURL(from: pokemon.id))
                                        .frame(width: 80, height: 80)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                        .shadow(radius: 5)
                                    
                                    Text(pokemon.name.capitalized)
                                        .font(.caption)
                                        .bold()
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                }
                                .padding()
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(12)
                                .shadow(radius: 5)
                            }
                        }
                        
                        if service.pokemons.count % 20 == 0 {
                            ProgressView()
                                .onAppear {
                                    service.fetchPokemons()
                                }
                        }
                    }
                    .padding()
                }
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            service.fetchPokemons()
        }
    }
    
    func fetchPokemonDetails(for pokemon: Pokemon) {
        guard let detailURL = URL(string: pokemon.url) else { return }
        
        URLSession.shared.dataTask(with: detailURL) { data, response, error in
            if let data = data {
                do {
                    let decodedDetail = try JSONDecoder().decode(PokemonDetail.self, from: data)
                    DispatchQueue.main.async {
                        self.selectedPokemonImageURL = decodedDetail.sprites.frontDefault
                        self.selectedPokemonName = pokemon.name
                    }
                } catch {
                    print("Failed to decode Pokémon details: \(error)")
                }
            }
        }.resume()
    }
    
    func getPokemonImageURL(from id: Int) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}

#Preview {
    ContentView()
}
