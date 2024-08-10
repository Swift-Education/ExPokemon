//
//  PokemonResponseDTO.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import Foundation

protocol Pagingable: Encodable {
    var offset: Int { get }
    var limit: Int { get }
}

struct Paging: Pagingable {
    let offset: Int
    let limit: Int
}

struct PokemonList: Decodable {
    let results: [Pokemon]
}

struct Pokemon: Decodable, Hashable {
    let name: String
    let url: String
    
    var thumbnailImageURL: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
    }
    
    var id: Int {
        let components = url.split(separator: "/")
        return Int(components.last ?? "0") ?? 0
    }
}

struct PokemonResponseDTO: Decodable {
    let id: Int
    let name: String
    let types: [TypeElement]
    let sprites: Sprites
    let height: Int
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case types
        case sprites
        case height
        case weight
    }
    
    func toDomain() -> PokemonDetail {
        return PokemonDetail(
            imageURL: sprites.frontDefault,
            title: "No.\(id) \(name)",
            type: types.first?.type.name ?? "None",
            height: "\(Double(height) / 10.0) m",
            weight: "\(Double(weight) / 10.0) kg"
        )
    }
}

// MARK: - TypeElement
struct TypeElement: Decodable {
    let slot: Int
    let type: Species
}

// MARK: - Species
struct Species: Decodable {
    let name: String
    let url: String
}

// MARK: - Sprites
struct Sprites: Decodable {
    let frontDefault: String
    let other: Other
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
