//
//  ContentView.swift
//  PokeTest
//
//  Created by John Kouris on 6/20/21.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    var pokemonModel = PokemonModel()
    @State private var pokemon = [Pokemon]()
    
    var body: some View {
        NavigationView {
            List(pokemon) { poke in
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(poke.name.capitalized)
                            .font(.title)
                        HStack {
                            Text(poke.type.capitalized)
                                .italic()
                            Circle()
                                .foregroundColor(poke.typeColor)
                                .frame(width: 10, height: 10)
                        }
                        Text(poke.description)
                            .font(.caption)
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    VStack {
//                        KFImage(URL(string: poke.imageURL))
//                            .interpolation(.none)
//                            .resizable()
//                            .frame(width: 100, height: 100)
                        
                        AsyncImage(url: URL(string: poke.imageURL)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                    .interpolation(.none)
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokemon")
            .onAppear {
                async {
                    pokemon = try! await pokemonModel.getPokemon()
                }
            }
//            .refreshable {
//                pokemon = try! await pokemonModel.getPokemon()
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
