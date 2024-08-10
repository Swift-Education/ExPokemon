//
//  NetworkManager.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import Foundation

final class NetworkManager {
    static let shared: NetworkManager = .init(
        session: .shared,
        config: APINetworkConfig(
            baseURL: URL(string: "https://pokeapi.co/api/v2/")!
        )
    )
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void
    private let session: URLSession
    private let config: NetworkConfiguarble
    static let baseURL: String = "https://pokeapi.co/api/v2/"
    
    init(session: URLSession, config: NetworkConfiguarble) {
        self.session = session
        self.config = config
    }
    
    func fetch(urlString: String, completion: @escaping ((Result<Data?, Error>) -> Void)) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard
                let data = data,
                let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode)
            else {
                completion(.failure(NSError(domain: "no data", code: -1)))
                return
            }
            
            completion(.success(data))
        }
        dataTask.resume()
    }
}

protocol NetworkService {
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void
    
    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<T>
    ) where E.Response == T
}
extension NetworkManager: NetworkService {
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E, completion: @escaping CompletionHandler<T>) where T == E.Response {
        guard let url = try? endpoint.url(with: config) else { return }
        let request = URLRequest(url: url)
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard
                let data = data,
                let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode)
            else {
                completion(.failure(NSError(domain: "no data", code: -1)))
                return
            }
            
            guard
                let userInfo: T = try? JSONDecoder().decode(
                    T.self,
                    from: data
                )
            else {
                completion(.failure(NSError(domain: "failed decode", code: -1)))
                return
            }
            print(userInfo)
            completion(.success(userInfo))
        }
        dataTask.resume()
    }
}
