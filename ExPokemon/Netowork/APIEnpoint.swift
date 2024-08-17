//
//  APIEnpoint.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import Foundation

struct APIEndpoints {
    static func getPokemonDetail(with pokemonID: Int) -> Endpoint<PokemonResponseDTO> {
        return Endpoint(
            path: "pokemon/\(pokemonID)",
            queryParameters: [:]
        )
    }
    
    static func getPokemonList(offset: Int = 0, limit: Int = NetworkManager.limit) -> Endpoint<PokemonList> {
        return Endpoint(
            path: "pokemon/",
            queryParameters: [
                "offset" : offset,
                "limit" : limit,
            ]
        )
    }
}



