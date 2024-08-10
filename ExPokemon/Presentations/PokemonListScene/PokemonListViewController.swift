//
//  PokemonListViewController.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import UIKit

final class PokemonListViewController: UIViewController {
    private let model: PokemonListModel
    private let rootView: PokemonListView
    
    init(model: PokemonListModel, rootView: PokemonListView) {
        self.model = model
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
        rootView.delegate = self
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
        model.fetchPokemonList { list in
            guard let list = list else { return }
            self.rootView.configure(model: list)
        }
    }
}

extension PokemonListViewController: PokemonListViewDelegate {
    func cooridinateVC(with index: Int) {
        let vc = PokemonDetailViewController(
            rootView: PokemonDetailView(frame: .zero),
            pokemonID: index,
            networkService: NetworkManager.shared
        )
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
