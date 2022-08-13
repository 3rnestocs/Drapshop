//
//  LoginPresenter.swift
//  Drapshop
//
//  Created by Ernesto Jose Contreras Lopez on 13/8/22.
//

import Foundation

class LoginPresenter {
    
    func checkCredential(_ credential: String?, type: TextType) -> Bool {
        guard let credential = credential else { return false }

        switch type {
        case .username:
            return credential == UserManager.getUser()?.username
        case .password:
            return credential == UserManager.getUser()?.password
        default:
            return false
        }
    }
    
}
