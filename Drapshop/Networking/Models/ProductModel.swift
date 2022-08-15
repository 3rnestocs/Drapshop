//
//  ProductModel.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 14/8/22.
//

import Foundation

struct Image: Codable {
    var description: String?
    var urls: ImageURL
}

struct ImageURL: Codable {
    var regular, full: String
}
