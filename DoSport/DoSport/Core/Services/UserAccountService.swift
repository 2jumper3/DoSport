//
//  UserAccountService.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 02/03/2021.
//

import Foundation

protocol UserAccountServiceProtocol {
    var currentUser: DSModels.Api.User.UserProfileResponse? { get }
    var currentUserID: DSModels.Api.User.UserProfileResponse.ID? { get }
    var isAuthorised: Bool { get }
    var dsToken: String? { get }
    
    func logOut()
}

/// Wrapper
final class UserAccountService: UserAccountServiceProtocol {
    
    var currentUser: DSModels.Api.User.UserProfileResponse? {
        return DSSharedData.shared.userData
    }
    
    var currentUserID: DSModels.Api.User.UserProfileResponse.ID? {
        return DSSharedData.shared.loginData.userID
    }
    
    var isAuthorised: Bool {
        return DSSharedData.shared.isLoggedIn
    }
    
    var dsToken: String? {
        return DSSharedData.shared.dsToken
    }
    
    func logOut() {
        DSSharedData.shared.loginData.logOut()
    }
}
