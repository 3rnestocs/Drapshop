//
//  String.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 15/8/22.
//

import Foundation

extension String {
    func firstCapitalized() -> String {
        self.prefix(1).capitalized + dropFirst()
    }
}
