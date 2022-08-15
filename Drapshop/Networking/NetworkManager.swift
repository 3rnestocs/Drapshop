//
//  NetworkManager.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 14/8/22.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://api.unsplash.com/photos"
    private var headers: HTTPHeaders {
        let auth = HTTPHeader(name: "Authorization", value: "Client-ID \(Environment.getEnvironmentVariable(name: .accessKey))")
        let version = HTTPHeader(name: "Accept-Version", value: "v1")
        let headers = HTTPHeaders([
            version, auth
        ])
        return headers
    }
    private var params: [String: Any] {
        let params = [
            "per_page": 30
        ]
        return params
    }
    
    func request<T: Codable>(_ type: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        AF.request(baseURL, method: .get, parameters: params, headers: headers).responseData { response in
            switch response.result {
            case .success(let data) :
                do {
                    guard let object = try? JSONDecoder().decode(type, from: data) else {
                        if let errorResult = try? JSONSerialization.jsonObject(with: data, options: []) as? CustomError {
                            completion(.failure(errorResult))
                        }
                        return
                    }
                    completion(.success(object))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
