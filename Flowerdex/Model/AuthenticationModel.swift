//
//  AuthenticationModel.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/1/20.
//

import Foundation

class LoginData: Codable {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func isComplete() -> Bool {
        if email == "" || password == "" {
            return false
        } else {
            return true
        }
    }
}

class RegistrationData: Codable {
    var username: String
    var password: String
    var email: String
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = password
    }
    
    func isComplete() -> Bool {
        if username == "" || password == "" || email == "" {
            return false
        } else {
            return true
        }
    }
}
