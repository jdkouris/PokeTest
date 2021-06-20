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
        List(pokemon) { poke in
            HStack {
                Text(poke.name.capitalized)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    KFImage(URL(string: poke.imageURL))
                        .interpolation(.none)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
            }
        }
        .onAppear {
            async {
                pokemon = try! await pokemonModel.getPokemon()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
