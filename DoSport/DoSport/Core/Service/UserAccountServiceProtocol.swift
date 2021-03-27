//
//  UserAccountService.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/03/2021.
//

import Foundation

protocol HasUserAccountService: class {
    var userAccountService: UserAccountServiceProtocol { get }
}

protocol UserAccountServiceProtocol: class {
    var currentUser: DSModels.User.UserView? { get set }
    var currentUserID: DSModels.User.UserView.ID? { get }
    
    var isAuthorised: Bool { get }
    var jwtToken: String? { get set }
    
    func logOut()
}

final class UserAccountService: UserAccountServiceProtocol {
    
    var currentUser: DSModels.User.UserView? {
        get { DSSharedData.shared.userData }
        set { DSSharedData.shared.userData = newValue }
    }
    
    var currentUserID: DSModels.User.UserView.ID? {
        DSSharedData.shared.userData?.id
    }
    
    var isAuthorised: Bool {
        DSSharedData.shared.isLoggedIn
    }
    
    var jwtToken: String? {
        get { DSSharedData.shared.jwtToken }
        set { DSSharedData.shared.jwtToken = newValue }
    }
    
    func logOut() {
        DSSharedData.shared.loginData.logOut()
    }
}
