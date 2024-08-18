//
//  PokemonListViewController.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import UIKit
import RxSwift

final class PokemonListViewController: UIViewController {
    private let rootView: PokemonListView
    private let viewModel: PokemonListViewModel
    private let disposeBag: DisposeBag = .init()
    
    init(rootView: PokemonListView, viewModel: PokemonListViewModel) {
        self.rootView = rootView
        self.viewModel = viewModel
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
        bind()
    }
    
    private func bind() {
        let load = self.rx.viewWillAppear
        let input = PokemonListViewModel.Input(load: load)
        let output = viewModel.transform(input)
        output.pokemonList
            .bind(to: rootView.collectionView.rx.items(cellIdentifier: PokemonListCell.reuseIdentifier, cellType: PokemonListCell.self)) {
                index, pokemon, cell in
                cell.configureCell(urlString: pokemon.thumbnailImageURL)
            }.disposed(by: disposeBag)
        
        rootView.collectionView.rx.modelSelected(Pokemon.self)
            .withUnretained(self)
            .subscribe { owner, pokemon in
                print(pokemon.id)
                let vc = PokemonDetailViewController(
                    rootView: PokemonDetailView(frame: .zero),
                    viewModel: PokemonDetailViewModel(pokemonId: pokemon.id)
                )
                owner.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)
    }
}

extension PokemonListViewController: PokemonListViewDelegate {
    func update(current: Int) {
//        viewModel.fetchPokemonList(offset: current)
//            .subscribe(onSuccess: { list in
//                self.rootView.update(model: list)
//            }).disposed(by: disposeBag)
    }
}
