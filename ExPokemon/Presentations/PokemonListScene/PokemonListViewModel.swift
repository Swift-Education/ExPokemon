//
//  PokemonListViewModel.swift
//  ExPokemon
//
//  Created by 강동영 on 8/17/24.
//

import Foundation
import RxSwift

final class PokemonListViewModel {
    private let model: PokemonListModel
    
    init(model: PokemonListModel) {
        self.model = model
    }
    
    func transform(_ input: Input) -> Output {
        let pokemonList = input.load
            .withUnretained(self) // value, load의 값이 튜플로 만들어줌
            .flatMapLatest { owner, _ in
                owner.model.fetchPokemonList()
            }
            .map { $0.results}
            .asObservable()
        return .init(pokemonList: pokemonList)
    }
}

extension PokemonListViewModel {
    struct Input {
        let load: Observable<Void>
    }
    
    struct Output {
        let pokemonList: Observable<[Pokemon]>
    }
}
