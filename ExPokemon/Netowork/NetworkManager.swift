//
//  NetworkManager.swift
//  ExPokemon
//
//  Created by 강동영 on 8/2/24.
//

import Foundation
import RxSwift

protocol NetworkService {
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E) -> Single<T> where T == E.Response
}

final class NetworkManager {
    static let limit: Int = 21
    static let shared: NetworkManager = .init(session: .shared)
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
}

extension NetworkManager: NetworkService {
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E) -> Single<T> where T == E.Response {
        do {
            let urlRequest = try endpoint.createRequest()
            print("url: \(urlRequest.url!.absoluteString)")
            return Single.create { single in
                let dataTask = self.session.dataTask(with: urlRequest) { data, response, error in
                    if let error = error {
                        single(.failure(error))
                    }
                    
                    guard
                        let data = data,
                        let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode)
                    else {
                        single(.failure(NSError(domain: "no data", code: -1)))
                        return
                    }
                    
                    guard
                        let userInfo: T = try? JSONDecoder().decode(
                            T.self,
                            from: data
                        )
                    else {
                        single(.failure(NSError(domain: "failed decode", code: -1)))
                        return
                    }
                    print(userInfo)
                    single(.success(userInfo))
                }
                dataTask.resume()
                return Disposables.create {
                    dataTask.cancel()
                }
            }
        } catch let error {
            return Single.create { single in
                single(.failure(error))
                return Disposables.create()
            }
        }
        
    }
}
