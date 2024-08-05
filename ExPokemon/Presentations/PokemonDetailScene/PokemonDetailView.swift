//
//  PokemonDetailView.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import UIKit

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
        DispatchQueue.main.async {
            self.layout()
        }
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
            stackview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
        self.layoutIfNeeded()
    }
    
    private func makeVerticalStackView(image: UIImage? = .pokemonBall) -> UIStackView {
        let stackview: UIStackView = .init()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.distribution = .fillEqually
        
        var imageView: UIImageView = makeLogoImageView(image: image)
        stackview.addArrangedSubview(imageView)
        NetworkManager.shared.fetch(urlString: pokemon.imageURL) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data!)
                    self.layoutIfNeeded()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        [
            makeInfoLabel(text: pokemon.title, font: .boldSystemFont(ofSize: 40)),
            makeInfoLabel(text: "type: \(pokemon.type)", font: .systemFont(ofSize: 20)),
            makeInfoLabel(text: "height: \(pokemon.height)", font: .systemFont(ofSize: 20)),
            makeInfoLabel(text: "weight: \(pokemon.weight)", font: .systemFont(ofSize: 20))
        ].forEach {
            stackview.addArrangedSubview($0)
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
