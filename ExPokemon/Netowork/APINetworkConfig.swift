//
//  APINetworkConfig.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import Foundation

protocol NetworkConfiguarble {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

struct APINetworkConfig: NetworkConfiguarble {
    let baseURL: URL
    let headers: [String: String]
    let queryParameters: [String: String]
    
    init(
        baseURL: URL,
        headers: [String : String] = [:],
        queryParameters: [String : String] = [:]
    ) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
