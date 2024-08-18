//
//  PokemonListCell.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import UIKit

final class PokemonListCell: UICollectionViewCell {
    static let reuseIdentifier: String = String(describing: PokemonListCell.self)
    
    private let imageView: UIImageView = UIImageView(image: UIImage.pokemonBall)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
    }
    
    private func setUpCell() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.backgroundColor = .systemBackground
        imageView.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
        
    public func configureCell(urlString: String) {
        self.imageView.fetch(with: urlString)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.cancelDownloadTask()
    }
}
