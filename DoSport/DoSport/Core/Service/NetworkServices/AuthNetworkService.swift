//
//  AuthNetworkService.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/03/2021.
//

import Foundation

protocol HasAuthNetworkService: class {
    var authNetworkService: AuthNetworkServiceProtocol { get }
}

protocol AuthNetworkServiceProtocol: class {
    func authSignIn(
        bodyObject: DSModels.Auth.SignInRequest,
        completion: @escaping (DataHandler<DSModels.Auth.SignInResponse>) -> Void)
}

final class AuthNetworkService: AuthNetworkServiceProtocol {
    
    private let networkManager: NetworkManager = NetworkManagerImplementation.shared
    
    /// This method will replaced by social media auth
    func authSignIn(
        bodyObject: DSModels.Auth.SignInRequest,
        completion: @escaping (DataHandler<DSModels.Auth.SignInResponse>) -> Void) {
        
        let endpoint = DSEndpoints.Auth.signIn
        
        networkManager.makeRequest(
            endpoint: endpoint,
            bodyObject: bodyObject,
            completion: completion)
    }
    
    /// This method will replaced by social media auth
    func authSignUp(
        bodyObject: DSModels.Auth.SignUpRequest,
        completion: @escaping (DataHandler<DSModels.User.UserView>) -> Void) {
        
        let endpoint = DSEndpoints.Auth.signUp
        
        networkManager.makeRequest(
            endpoint: endpoint,
            bodyObject: bodyObject,
            completion: completion)
    }
}
