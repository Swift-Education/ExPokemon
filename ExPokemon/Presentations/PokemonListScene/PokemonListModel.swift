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
    private var currentOffset: Int = 0
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPokemonList(offset: Int = 0) -> Single<PokemonList> {
        currentOffset += offset
        let endpoint = APIEndpoints.getPokemonList(offset: currentOffset)
        return networkService.request(with: endpoint)
    }
}
