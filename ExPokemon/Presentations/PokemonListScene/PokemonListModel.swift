//
//  PokemonListModel.swift
//  ExPokemon
//
//  Created by 강동영 on 8/10/24.
//

import Foundation
import RxSwift

final class PokemonListModel {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPokemonList(offset: Int = 0, limit: Int = 20) -> Single<PokemonList> {
        let endpoint = APIEndpoints.getPokemonList(offset: offset, limit: limit)
        return networkService.request(with: endpoint)
    }
}
