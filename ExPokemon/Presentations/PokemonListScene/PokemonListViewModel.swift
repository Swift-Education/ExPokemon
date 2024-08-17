//
//  PokemonListViewModel.swift
//  ExPokemon
//
//  Created by 강동영 on 8/17/24.
//

import Foundation

final class PokemonListViewModel {
    private let model: PokemonListModel
    
    init(model: PokemonListModel) {
        self.model = model
    }
    
    func fetchPokemonList(offset: Int = 0, completion: @escaping (([Pokemon]?) -> Void)) {
        model.fetchPokemonList { list in
            completion(list)
        }
    }
}
