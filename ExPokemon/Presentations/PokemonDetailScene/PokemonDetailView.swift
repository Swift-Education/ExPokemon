//
//  PokemonDetailView.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import UIKit

final class PokemonDetailView: UIView {
    private var pokemon: PokemonDetail!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = PokeColor.pokeBackgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPokemonInfo(_ info: PokemonDetail) {
        pokemon = info
        DispatchQueue.main.async {
            self.layout()
        }
    }
}

extension PokemonDetailView {
    private func layout() {
        let containerView: UIView = {
            let view: UIView = .init(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = PokeColor.detailBackgroundColor
            return view
        }()
        let imageView: UIImageView = makeLogoImageView()
        let stackview: UIStackView = makeVerticalStackView()
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(stackview)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1/2),
            
            imageView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.45),
            
            stackview.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 10),
            stackview.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackview.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackview.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
        ])
        
        self.layoutIfNeeded()
    }
    
    private func makeLogoImageView(image: UIImage? = .pokemonBall) -> UIImageView {
        let imageView: UIImageView = .init(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        NetworkManager.shared.fetch(urlString: pokemon.imageURL) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data!)
                    imageView.layoutIfNeeded()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        return imageView
    }
    
    private func makeVerticalStackView(image: UIImage? = .pokemonBall) -> UIStackView {
        let stackview: UIStackView = .init()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        
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
    
    private func makeInfoLabel(text: String, font: UIFont = .systemFont(ofSize: 20)) -> UILabel {
        let label: UILabel = .init(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = text
        label.font = font
        label.textColor = .white
        return label
    }
}
