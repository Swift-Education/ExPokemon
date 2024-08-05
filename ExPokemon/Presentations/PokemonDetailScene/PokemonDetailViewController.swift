//
//  PokemonDetailViewController.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import UIKit

final class PokemonDetailViewController: UIViewController {
    private let rootView: PokemonDetailView
    private let pokemonID: Int
    private let networkService: NetworkService
    init(rootView: PokemonDetailView, pokemonID: Int, networkService: NetworkService) {
        self.rootView = rootView
        self.pokemonID = pokemonID
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let endpoint = APIEndpoints.getPokemonDetail(with: pokemonID)
        networkService.request(with: endpoint) { result in
            switch result {
            case .success(let pokemon):
                self.rootView.setPokemonInfo(pokemon.toDomain())
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
