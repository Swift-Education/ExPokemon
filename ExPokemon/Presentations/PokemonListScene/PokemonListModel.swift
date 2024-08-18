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
    private var pokemonList: [Pokemon] = []
    private let disposeBag: DisposeBag = .init()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPokemonList(offset: Int = 0, completion: @escaping (([Pokemon]?) -> Void)) {
        let endpoint = APIEndpoints.getPokemonList(offset: pokemonList.count)
        networkService.request(with: endpoint)
            .subscribe { list in
                self.pokemonList += list.results
                completion(self.pokemonList)
            } onFailure: { error in
                print(error.localizedDescription)
                completion(nil)
            }.disposed(by: disposeBag)
    }
}
