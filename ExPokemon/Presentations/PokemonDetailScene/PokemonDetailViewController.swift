//
//  PokemonDetailViewController.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import UIKit
import RxSwift

final class PokemonDetailViewController: UIViewController {
    private let rootView: PokemonDetailView
    private let viewModel: PokemonDetailViewModel
    private let disposeBag: DisposeBag = .init()
    
    init(rootView: PokemonDetailView, viewModel: PokemonDetailViewModel) {
        self.rootView = rootView
        self.viewModel = viewModel
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
        bind()
    }
    
    private func bind() {
        let load = self.rx.viewWillAppear
        let input = PokemonDetailViewModel.Input(load: load)
        let output = viewModel.transform(input)
        let detail = output.pokemonDetail.share()
        
        output.pokemonDetail
            .subscribe(onNext: { detail in
                self.rootView.setPokemonInfo(detail)
            }).disposed(by: disposeBag)
    }
}
