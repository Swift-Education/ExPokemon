//
//  NetworkLogger.swift
//  ExPokemon
//
//  Created by 강동영 on 8/18/24.
//

import Foundation

protocol NetworkLoggerInterface {
    func requestLogger(request: URLRequest)
    func responseLogger(response: URLResponse, data: Data)
}

final class NetworkLogger: NetworkLoggerInterface {
    func requestLogger(request: URLRequest) {
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
    
    func responseLogger(response: URLResponse, data: Data) {
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

private extension Data {
    var toPrettyPrintedString: String? {
        guard
            let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.withoutEscapingSlashes, .prettyPrinted]),
            let prettyPrintedString = String(data: data, encoding: .utf8)
        else {
            return nil
        }
        return prettyPrintedString
    }
}
