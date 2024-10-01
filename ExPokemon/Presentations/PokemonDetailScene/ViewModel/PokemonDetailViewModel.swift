//
//  PokemonDetailViewModel.swift
//  ExPokemon
//
//  Created by 강동영 on 8/18/24.
//

import Foundation
import RxSwift

class PokemonDetailViewModel: ViewModelAble {
    private let model = PokemonDetailModel(networkService: NetworkManager.shared)
    let pokemonId: Int
    
    init(pokemonId: Int) {
        self.pokemonId = pokemonId
    }
    
    func transform(_ input: Input) -> Output {
        let pokemonDetail = input.load
            .withUnretained(self) // value, load의 값이 튜플로 만들어줌
            .flatMapLatest { owner, _ in
                owner.model.fetchPokemonDetail(with: owner.pokemonId)
            }
            .map { $0.toDomain() }
            .asObservable()
        return .init(pokemonDetail: pokemonDetail)
    }
}

extension PokemonDetailViewModel {
    struct Input {
        let load: Observable<Void>
    }
    
    struct Output {
        let pokemonDetail: Observable<PokemonDetail>
    }
}
