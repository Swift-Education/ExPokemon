//
//  PokemonListView.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import UIKit

protocol ViewCoordianateAbleWithIndex {
    func cooridinateVC(with index: Int)
}

protocol PokemonListViewDelegate: ViewCoordianateAbleWithIndex, AnyObject {}

final class PokemonListView: UIView {
    private let collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        return collectionView
    }()
    
    weak var delegate: PokemonListViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed
        layout()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PokemonListView {
    private func layout() {
        let imageView: UIImageView = makeLogoImageView()
        addSubview(imageView)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1 / 5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            collectionView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func makeLogoImageView() -> UIImageView {
        let imageView: UIImageView = .init(image: UIImage.pokemonBall)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        collectionView.register(PokemonListCell.self, forCellWithReuseIdentifier: PokemonListCell.reuseIdentifier)
        collectionView.reloadData()
    }
}

extension PokemonListView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonListCell.reuseIdentifier, for: indexPath)
        guard let convertedCell = cell as? PokemonListCell else { return cell }
        convertedCell.configureCell(index: indexPath.item + 1)
        return convertedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PokemonDetailViewController()
        delegate?.cooridinateVC(with: indexPath.item + 1)
    }
}

extension PokemonListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 10
        return CGSize(width: width, height: width)
    }
}
