//
//  Endpoint.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import Foundation

class Endpoint<R>: ResponseRequestable {
    
    typealias Response = R
    
    let baseURL: String
    let path: String
    let isFullPath: Bool
    let method: HTTPMethodType
    let headerParameters: [String: String]
    let queryParameters: [String: Any]
    let bodyParameters: [String: Any]
    let responseDecoder: ResponseDecoder
    let logger: NetworkLoggerInterface
    
    init(baseURL: String = "https://pokeapi.co/api/v2",
         path: String,
         isFullPath: Bool = false,
         method: HTTPMethodType = .get,
         headerParameters: [String: String] = [:],
         queryParametersEncodable: Encodable? = nil,
         queryParameters: [String: Any] = [:],
         bodyParametersEncodable: Encodable? = nil,
         bodyParameters: [String: Any] = [:],
         responseDecoder: ResponseDecoder = JSONResponseDecoder(),
         logger: NetworkLoggerInterface = NetworkLogger()
    ) {
        self.baseURL = baseURL
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.responseDecoder = responseDecoder
        self.logger = logger
    }
}
