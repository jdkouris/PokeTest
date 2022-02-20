//
//  ContentView.swift
//  PokeTest
//
//  Created by John Kouris on 6/20/21.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @ObservedObject var pokemonVM = PokemonViewModel()
    @State private var searchText = ""
    
    var filteredPokemon: [Pokemon] {
        if searchText == "" { return pokemonVM.pokemon }
        return pokemonVM.pokemon.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredPokemon) { pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(pokemon.name.capitalized)
                                        .font(.title)
                                    if pokemon.isFavorite {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                
                                HStack {
                                    Text(pokemon.type.capitalized)
                                        .italic()
                                    Circle()
                                        .foregroundColor(pokemon.typeColor)
                                        .frame(width: 10, height: 10)
                                }
                                
                                Text(pokemon.description)
                                    .font(.caption)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                            
                            VStack {
                                KFImage(URL(string: pokemon.imageURL))
                                    .interpolation(.none)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(action: { addFavorite(pokemon: pokemon) }) {
                            Image(systemName: "star")
                        }
                        .tint(.yellow)
                    }
                }
            }
            .navigationTitle("Pokemon")
            .searchable(text: $searchText)
        }
    }
    
    func addFavorite(pokemon: Pokemon) {
        if let index = pokemonVM.pokemon.firstIndex(where: { $0.id == pokemon.id }) {
            pokemonVM.pokemon[index].isFavorite.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
