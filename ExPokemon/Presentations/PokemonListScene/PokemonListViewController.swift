//
//  PokemonListViewController.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import UIKit

final class PokemonListViewController: UIViewController {
    private let rootView: PokemonListView
    
    init(rootView: PokemonListView) {
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
    }
}

extension PokemonListViewController: PokemonListViewDelegate {
    func cooridinateVC(with index: Int) {
        let vc = PokemonDetailViewController(rootView: PokemonDetailView(frame: .zero))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
