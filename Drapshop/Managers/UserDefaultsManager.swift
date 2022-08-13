//
//  UserDefaultsManager.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 13/8/22.
//

import Foundation

class UserManager {
    static func updateUser(_ user: User) {
        UserDefaults.standard.user = user
    }
    
    static func deleteUser(_ user: User) {
        UserDefaults.standard.user = nil
    }
    
    static func getUser() -> User? {
        return UserDefaults.standard.user
    }
}
