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
    
    private var datasource: UICollectionViewDiffableDataSource<Section, Item>!
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
        datasource = makeDatasource()
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        makeSnapshot(item: Item.stub1)
    }
}

extension PokemonListView {
    fileprivate enum Section {
        case pokemon
    }
    
    fileprivate struct Item: Hashable {
        let id: Int
        
        static let stub1: [Item] = {
            return stride(from: 1, through: 20, by: 1).map { Item(id: $0)}
        }()
    }
    
    private func makeDatasource() -> UICollectionViewDiffableDataSource<Section, Item> {
        let cellResistration = UICollectionView.CellRegistration<PokemonListCell, Item> {cell,indexPath,itemIdentifier in
            cell.configureCell(index: itemIdentifier.id)
        }
        
        let datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellResistration, for: indexPath, item: itemIdentifier)
        }
        
        
        return datasource
    }
    
    private func makeSnapshot(item: [Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.pokemon])
        snapshot.appendItems(item)
        datasource.apply(snapshot)
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
