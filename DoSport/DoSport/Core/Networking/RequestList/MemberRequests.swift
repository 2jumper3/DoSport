//
//  MemberRequests.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 03/03/2021.
//

import Foundation
import Alamofire

extension RequestFactory {
    
    func memberLogin(
        params: DSModels.Api.Auth.LoginRequest,
        completion: @escaping (AFDataResponse<DSModels.Api.Auth.LoginResponse>) -> Void
    ) {
        let requestEndpoint = DSEndpoints.Authentification.Login(params: params)
        request(request: requestEndpoint, completionHandler: completion)
    }
    
    func memberRegister(
        params: DSModels.Api.Auth.RegisterRequest,
        completion: @escaping (AFDataResponse<DSModels.Api.Auth.RegisterResponse>) -> Void
    ) {
        let requestEndpoint = DSEndpoints.Authentification.Register(params: params)
        request(request: requestEndpoint, completionHandler: completion)
    }
}
