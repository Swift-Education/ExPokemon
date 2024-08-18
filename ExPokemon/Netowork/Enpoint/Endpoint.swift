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
    
    init(baseURL: String = "https://pokeapi.co/api/v2",
         path: String,
         isFullPath: Bool = false,
         method: HTTPMethodType = .get,
         headerParameters: [String: String] = [:],
         queryParametersEncodable: Encodable? = nil,
         queryParameters: [String: Any] = [:],
         bodyParametersEncodable: Encodable? = nil,
         bodyParameters: [String: Any] = [:],
         responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        self.baseURL = baseURL
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.responseDecoder = responseDecoder
    }
}

//MARK: - Network Logger
extension Requestable {
    internal func requestLogger(request: URLRequest) {
        print("")
        debugPrint("======================== 👉 Network Request Log 👈 ==========================")
        debugPrint("✅ [URL] : \(request.url?.absoluteString ?? "")")
        debugPrint("✅ [Method] : \(request.httpMethod ?? "")")
        debugPrint("✅ [Headers] : \(request.allHTTPHeaderFields ?? [:])")
        
        if let body = request.httpBody?.toPrettyPrintedString {
            debugPrint("✅ [Body] : \(body)")
        } else {
            debugPrint("✅ [Body] : body 없음")
        }
        debugPrint("==============================================================================")
        print("")
    }
    
    internal func responseLogger(response: URLResponse, data: Data) {
        print("")
        debugPrint("======================== 👉 Network Response Log 👈 ==========================")
        
        guard let response = response as? HTTPURLResponse else {
            debugPrint("✅ [Response] : HTTPURLResponse 캐스팅 실패")
            return
        }
        
        debugPrint("✅ [StatusCode] : \(response.statusCode)")
        
        switch response.statusCode {
        case 400..<500:
            debugPrint("🚨 클라이언트 오류")
        case 500..<600:
            debugPrint("🚨 서버 오류")
        default:
            break
        }
        
        debugPrint("✅ [ResponseData] : \(data.toPrettyPrintedString ?? "")")
        debugPrint("===============================================================================")
        print("")
    }
}
