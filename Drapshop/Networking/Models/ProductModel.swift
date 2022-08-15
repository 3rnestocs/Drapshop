//
//  ProductModel.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 14/8/22.
//

import Foundation

struct Image: Codable {
    var id: String?
    var description: String?
    var urls: ImageURL
    
    func getName(_ index: Int) -> String {
        guard let description = description else {
            return "Product \(index)"
        }
        return description
    }
}

struct ImageURL: Codable {
    var regular: String
}
