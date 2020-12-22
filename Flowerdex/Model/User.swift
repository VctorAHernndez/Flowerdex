//
//  User.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 12/20/20.
//

import Foundation

class User: Codable, Identifiable { // not a hashable struct anymore :(
    
    // REFERENCE: https://www.makeschool.com/academy/track/build-ios-apps/build-a-photo-sharing-app/keeping-users-logged-in
    
    let id: Int?
    let username: String?
    let email: String
    let password: String?
    
    private static var _current: User?
    
    static var current: User {
        guard let currentUser = User._current else {
            fatalError("Error: Current user doesn't exist")
        }
        
        return currentUser
    }
    
    // TODO: implement save to keychain on wtud == false
    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        if writeToUserDefaults {
            if let data = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }
        _current = user
    }
    
    static func fetchCurrent() -> User? {
        if let userData = UserDefaults.standard.object(forKey: Constants.UserDefaults.currentUser) as? Data,
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            print("from fetchCurrent(): \(String(describing: user))")
            User.setCurrent(user)
            return user
        } else {
            return nil
        }
    }
    
    static func exists() -> Bool {
        let user = fetchCurrent()
        print("from exists(): \(String(describing: user))")
        if user != nil {
            return true
        } else {
            return false
        }
    }
    
    static func logout() {
        UserDefaults.standard.removeObject(forKey: Constants.UserDefaults.currentUser)
    }
    
}
