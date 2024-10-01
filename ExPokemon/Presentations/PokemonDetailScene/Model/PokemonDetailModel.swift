//
//  PokemonDetailModel.swift
//  ExPokemon
//
//  Created by 강동영 on 8/18/24.
//

import Foundation
import RxSwift

final class PokemonDetailModel {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPokemonDetail(with id: Int) -> Single<PokemonResponseDTO> {
        let endpoint = APIEndpoints.getPokemonDetail(with: id)
        return networkService.request(with: endpoint)
    }
}
