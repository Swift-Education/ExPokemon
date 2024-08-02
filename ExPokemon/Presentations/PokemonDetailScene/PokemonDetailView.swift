//
//  PokemonDetailView.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import UIKit

struct Pokemon {
    let name: String
    let info: [String: String]
}

final class PokemonDetailView: UIView {
    private var pokemon: Pokemon!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPokemonInfo(_ info: Pokemon) {
        pokemon = info
        layout()
        layoutIfNeeded()
    }
}

extension PokemonDetailView {
    private func layout() {
        let stackview: UIStackView = makeVerticalStackView()
        addSubview(stackview)
        
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    private func makeVerticalStackView(image: UIImage? = .pokemonBall) -> UIStackView {
        let stackview: UIStackView = .init()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.addArrangedSubview(makeLogoImageView(image: image))
        
        stackview.addArrangedSubview(
            makeInfoLabel(text: pokemon.name, font: .boldSystemFont(ofSize: 40))
        )
        pokemon.info.forEach {
            stackview.addArrangedSubview(
                makeInfoLabel(text: "\($0): \($1))", font: .systemFont(ofSize: 20))
            )
        }
        return stackview
    }
    
    private func makeLogoImageView(image: UIImage? = .pokemonBall) -> UIImageView {
        let imageView: UIImageView = .init(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func makeInfoLabel(text: String, font: UIFont = .systemFont(ofSize: 20)) -> UILabel {
        let label: UILabel = .init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = text
        label.font = font
        return label
    }
}
