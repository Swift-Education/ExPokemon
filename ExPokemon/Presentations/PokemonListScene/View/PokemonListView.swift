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

protocol CollectionViewInfinityScollable {
    func update(current offset: Int)
}

protocol PokemonListViewDelegate: ViewCoordianateAbleWithIndex, CollectionViewInfinityScollable, AnyObject {}

final class PokemonListView: UIView {
    let collectionView: UICollectionView = {
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = PokeColor.detailBackgroundColor
        return collectionView
    }()
    
    private var model: [Pokemon] = []
    
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
    
    public func configure(model: [Pokemon]) {
        self.model = model
    }
    
    public func update(model: [Pokemon]) {
        self.model.append(contentsOf: model)
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
        collectionView.delegate = self
        collectionView.register(PokemonListCell.self, forCellWithReuseIdentifier: PokemonListCell.reuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

extension PokemonListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cooridinateVC(with: indexPath.item + 1)
    }
}

extension PokemonListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 10
        return CGSize(width: width, height: width)
    }
}

extension PokemonListView: UIScrollViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height / 2
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            delegate?.update(current: model.count)
            print("scrollView.contentOffset.y: \(scrollView.contentOffset.y)")
        }
    }
}
