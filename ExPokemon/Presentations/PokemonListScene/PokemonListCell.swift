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
    
    private func fetchImage(with urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
        
        session.resume()
    }
    
    public func configureCell(index: Int) {
        let string = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(index).png"
        fetchImage(with: string) { image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
}
