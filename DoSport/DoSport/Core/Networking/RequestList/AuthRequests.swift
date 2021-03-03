//
//  AuthRequests.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import Foundation
import Alamofire

extension RequestFactory {
    
    func authLogin(
        params: DSModels.Api.Auth.LoginRequest,
        completion: @escaping (AFDataResponse<DSModels.Api.Auth.LoginResponse>) -> Void
    ) {
        let requestEndpoint = DSEndpoints.Authentification.Login(params: params)
        request(request: requestEndpoint, completionHandler: completion)
    }
    
    func authRegister(
        params: DSModels.Api.Auth.RegisterRequest,
        completion: @escaping (AFDataResponse<DSModels.Api.Auth.RegisterResponse>) -> Void
    ) {
        let requestEndpoint = DSEndpoints.Authentification.Register(params: params)
        request(request: requestEndpoint, completionHandler: completion)
    }
}



