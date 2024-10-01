//
//  PokemonListViewModel.swift
//  ExPokemon
//
//  Created by 강동영 on 8/17/24.
//

import Foundation
import RxSwift
import RxCocoa

final class PokemonListViewModel {
    private let model: PokemonListModel
    private var curronOffset = 0
    private let limit = 20
    private let pokemonListRelay: BehaviorRelay<[Pokemon]> = .init(value: [])
    private let disposeBag: DisposeBag = .init()
    
    init(model: PokemonListModel) {
        self.model = model
    }
    
    func transform(_ input: Input) -> Output {
        let initialLoad = input.load
            .withUnretained(self) // value, load의 값이 튜플로 만들어줌
            .flatMapLatest { owner, _ in
                owner.model.fetchPokemonList(offset: 0, limit: owner.limit)
            }
            .do(onNext: { [weak self] response in
                guard let self = self else { return }
                self.curronOffset = self.limit
                self.pokemonListRelay.accept(response.results)
            })
        
        let loadMore = input.loadMore
            .withUnretained(self)
            .filter { owner, _ in
                owner.curronOffset > 0
            }
            .flatMapLatest { owner, _ in
                owner.model.fetchPokemonList(offset: owner.curronOffset, limit: owner.limit)
            }
            .do(onNext: { [weak self] response in
                guard let self = self else { return }
                self.curronOffset += self.limit
                self.pokemonListRelay.accept(self.pokemonListRelay.value + response.results)
            })
        
        Observable.merge(initialLoad, loadMore)
            .subscribe()
            .disposed(by: disposeBag)
        
        return .init(pokemonList: pokemonListRelay.asObservable())
    }
}

extension PokemonListViewModel {
    struct Input {
        let load: Observable<Void>
        let loadMore: Observable<Void>
    }
    
    struct Output {
        let pokemonList: Observable<[Pokemon]>
    }
}
