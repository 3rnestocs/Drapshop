//
//  ProductModel.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 14/8/22.
//

import Foundation

struct ProductResponse: Codable {
    var categoryName: String?
    var itemCount: Int?
    var products: [Product]?
}

struct Product: Codable {
    var id: Int?
    var name: String?
    var price: Price?
    var brandName: String?
    var imageUrl: String?
    
    func getImage() -> String? {
        guard let imageUrl = imageUrl else {
            return nil
        }
        return "http://\(imageUrl)"
    }
    
    func getName() -> String? {
        guard let name = name else {
            return nil
        }
        return name.trimmingCharacters(in: CharacterSet(charactersIn: "ASOS DESIGN 4505")).firstCapitalized()
    }
}

struct Price: Codable {
    var current: GenericField
    var currency: String
}

struct GenericField: Codable {
    var value: Double
    var text: String
}
