//
//  Environment.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 14/8/22.
//

import Foundation

struct Environment {
    enum VariableName: String {
        case accessKey = "ACCESS_KEY"
    }

    static func getEnvironmentVariable(name: VariableName) -> String {
        let environmentDictionary = Bundle.main.infoDictionary!
        guard let variable = environmentDictionary[name.rawValue] as? String else {
            return ""
        }

        return variable
    }
}
