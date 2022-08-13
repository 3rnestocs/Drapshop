//
//  SignupPresenter.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 13/8/22.
//

import Foundation

enum ValidationCase {
    case empty
    case shortUser
    case shortPassword
    case none
}

class SignupPresenter {

    func registerUser(password: String?, username: String?) {
        guard let password = password, let username = username else { return }
        let newUser = User(username: username, password: password)
        UserDefaults.standard.user = newUser
    }

    func checkCredential(_ credential: String?, type: TextType) -> ValidationCase {
        guard let credential = credential else { return .empty }
        if credential.isEmpty {
            return .empty
        } else if credential.count < 3 && type == .username {
            return .shortUser
        } else if credential.count < 8 && type == .password {
            return .shortPassword
        } else {
            return .none
        }
    }
}
