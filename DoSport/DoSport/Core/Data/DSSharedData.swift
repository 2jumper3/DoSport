//
//  DSSharedData.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 02/03/2021.
//

import Foundation

// works after Auth
final class DSSharedData {
    
    static let shared = DSSharedData()
    
    enum Key {
        static let jwt = "jwt"
        static let userdata = "userdata"
    }

    let loginData = DSLoginData.shared
    
    let userDefaults = UserDefaults.appShared

    var userData: DSModels.User.UserView? {
        get { self.getUserData() }
        set { self.setUserData(newValue) }
    }

    var jwtToken: String? {
        get { loginData.jwtToken }
        set { loginData.jwtToken = newValue }
    }

    var isLoggedIn: Bool {
        self.userData != nil && self.jwtToken != nil
    }
}

//MARK: Private API

private extension DSSharedData {
    
    func getUserData() -> DSModels.User.UserView? {
        guard let data = userDefaults.data(forKey: Key.userdata) else { return nil }
        
        return try? JSONDecoder().decode(DSModels.User.UserView.self, from: data)
    }
    
    func setUserData(_ data: DSModels.User.UserView?) {
        let encoder = JSONEncoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.DS_DateFormat
        dateFormatter.locale = Locale(identifier: "ru_RU_POSIX")
        
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        
        let data = try? encoder.encode(data)
        userDefaults.set(data, forKey: Key.userdata)
    }
}
