//
//  NetworkManager.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import Foundation

final class NetworkManager {
    static let shared: NetworkManager = .init(session: .shared)
    
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
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


//extension NetworkManager: NetworkService {
//    func request(
//        endpoint: Requestable,
//        completion: @escaping CompletionHandler
//    ) -> URLSessionDataTask? {
//        do {
//            let urlRequest = try endpoint.urlRequest(with: config)
//            return request(request: urlRequest, completion: completion)
//        } catch {
//            completion(.failure(.urlGeneration))
//            return nil
//        }
//    }
//}

protocol NetworkService {
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void
    
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E,
        completion: @escaping CompletionHandler<T>
    ) where E.Response == T
}
extension NetworkManager: NetworkService {
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E, completion: @escaping CompletionHandler<T>) where T == E.Response {
        guard let url = try? endpoint.url() else { return }
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
            else { return }
            endpoint.logger.responseLogger(response: response, data: data)
            completion(.success(userInfo))
        }
        dataTask.resume()
    }
}
