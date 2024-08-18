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
    
    func fetchPokemonList(offset: Int = 0) -> Observable<[Pokemon]?> {
        return Observable.create { observer in
            self.model.fetchPokemonList(offset: offset) { list in
                observer.onNext(list)
            }
            return Disposables.create()
        }
        
    }
}
