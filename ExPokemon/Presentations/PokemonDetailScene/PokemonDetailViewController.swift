//
//  PokemonDetailViewController.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import UIKit

final class PokemonDetailViewController: UIViewController {
    private let rootView: PokemonDetailView
    
    init(rootView: PokemonDetailView) {
        self.rootView = rootView
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
    }
}
