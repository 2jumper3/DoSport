//
//  DSSharedData.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 02/03/2021.
//

import Foundation

// works after Auth
class DSSharedData {
    
    static let shared = DSSharedData()
    
    let loginData = LoginData.shared
    
    enum Constants {
        static let dsToken = "dsToken"
        static let userID = "userID"
        static let userdata = "userdata"
    }
    
    let userDefaults = UserDefaults.appShared
    
    var userData: DSModels.Api.User? {
        get { return nil }
        set { }
    }
    
    var dsToken: String? {
        loginData.dsToken
    }
    
    var isLoggedIn: Bool {
        return dsToken != nil
    }
}
