//
//  ErrorModel.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 14/8/22.
//

import Foundation

struct CustomError: Error, Codable {
    var errors: [String]
}
