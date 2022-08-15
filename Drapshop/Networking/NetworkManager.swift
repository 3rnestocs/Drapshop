//
//  NetworkManager.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 14/8/22.
//

import Foundation
import Alamofire

enum Endpoints: String {
    case productList = "/products/v2/list"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://asos2.p.rapidapi.com"
    private var headers: HTTPHeaders {
        let auth = HTTPHeader(name: "X-RapidAPI-Key", value: "\(Environment.getEnvironmentVariable(name: .accessKey))")
        let version = HTTPHeader(name: "X-RapidAPI-Host", value: "asos2.p.rapidapi.com")
        let headers = HTTPHeaders([
            version, auth
        ])
        return headers
    }
    private var params: [String: Any]? {
        var params: [String: Any]?
        switch endpoint {
        case .productList:
            params = [
                "store": "US", "offset": 0, "categoryId": 3159, "limit": 60
            ]
        }
        return params
    }
    lazy var endpoint: Endpoints = currentEndpoint()
    
    func request<T: Codable>(_ type: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        AF.request(baseURL+endpoint.rawValue, method: .get, parameters: params, headers: headers).responseData { response in
            switch response.result {
            case .success(let data) :
                do {
                    guard let object = try? JSONDecoder().decode(type, from: data) else {
                        return
                    }
                    completion(.success(object))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func currentEndpoint() -> Endpoints {
        .productList
    }
}
