//
//  UserDefaults.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 13/8/22.
//

import Foundation

enum UserDefaultsKeys: String, CaseIterable {
    case user
}

extension UserDefaults {
    var user: User? {
        get {
            guard let data = data(forKey: UserDefaultsKeys.user.rawValue) else { return nil }
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(User.self, from: data)
            } catch {
                return nil
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                set(data, forKey:UserDefaultsKeys.user.rawValue)
            } catch {
                set(nil, forKey: UserDefaultsKeys.user.rawValue)
            }
        }
    }
}
