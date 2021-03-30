//
//  DSLoginData.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 02/03/2021.
//

import Foundation

final class DSLoginData {
    static let shared = DSLoginData()
    
    private let userDefaults = UserDefaults.appShared
    private let keychain = DSKeychainService()
    
    var jwtToken: String? {
        get {
            keychain.get(DSSharedData.Key.jwt)
        }
        set {
            keychain.set(newValue!, forKey: DSSharedData.Key.jwt)
        }
    }
}

//MARK: Public API

extension DSLoginData {
    
    func logIn(jwtToken: String) {
        self.jwtToken = jwtToken
    }
    
    func logOut() {
        userDefaults.resetDefaults()
        self.clear()
        URLCache.shared.removeAllCachedResponses()
    }
    
    func clear() {
        userDefaults.removeSuite(named: UserDefaults.appSuiteName)
        keychain.clear()
    }
}

/// Creates a user defaults object initialized with the defaults for the specified database name
extension UserDefaults {
    static let appSuiteName = "userDefaults.vladmusuz.DoSportiOS"
    
    static var appShared: UserDefaults {
        return UserDefaults(suiteName: UserDefaults.appSuiteName)!
    }
}

extension UserDefaults {
    func resetDefaults() {
        let dictionary = self.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            self.removeObject(forKey: key)
        }
    }
}




