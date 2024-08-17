//
//  PokemonListModel.swift
//  ExPokemon
//
//  Created by 강동영 on 8/10/24.
//

import Foundation

final class PokemonListModel {
    private let networkService: NetworkService
    private var pokemonList: [Pokemon] = []
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPokemonList(offset: Int = 0, completion: @escaping (([Pokemon]?) -> Void)) {
        let endpoint = APIEndpoints.getPokemonList(offset: pokemonList.count)
        networkService.request(with: endpoint) { result in
            switch result {
            case .success(let list):
                self.pokemonList += list.results
                completion(self.pokemonList)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
