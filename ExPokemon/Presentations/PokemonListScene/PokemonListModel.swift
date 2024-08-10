//
//  PokemonListModel.swift
//  ExPokemon
//
//  Created by 강동영 on 8/10/24.
//

import Foundation

final class PokemonListModel {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPokemonList(offset: Int = 0, limit: Int = 20, completion: @escaping ((PokemonList?) -> Void)) {
        let endpoint = APIEndpoints.getPokemonList(offset: offset, limit: limit)
        networkService.request(with: endpoint) { result in
            switch result {
            case .success(let list):
                completion(list)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
