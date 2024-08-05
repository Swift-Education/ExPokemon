//
//  PokemonResponseDTO.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import Foundation

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
    
    func toDomain() -> Pokemon {
        return Pokemon(
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
class Sprites: Decodable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
