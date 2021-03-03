//
//  UserRequests.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 03/03/2021.
//

import Foundation
import Alamofire

extension RequestFactory {
    
    func userGetProfile(
        completion: @escaping (AFDataResponse<DSModels.Api.User.UserProfileResponse>) -> Void
    ) {
        let requestEndpoint = DSEndpoints.User.GetUserProfile()
        request(request: requestEndpoint, completionHandler: completion)
    }
    
    func userGetById(
        params: DSModels.Api.User.GetUserProfileById,
        completion: @escaping (AFDataResponse<DSModels.Api.User.UserProfileResponse>) -> Void
    ) {
        let requestEndpoint = DSEndpoints.User.GetUserProfileById(params: params)
        request(request: requestEndpoint, completionHandler: completion)
    }
    
    func userProfileEdit(
        params: DSModels.Api.User.EditUserProfile,
        completion: @escaping (AFDataResponse<DSModels.Api.User.UserProfileResponse>) -> Void
    ) {
        let requestEndpoint = DSEndpoints.User.EditUserProfile(params: params)
        request(request: requestEndpoint, completionHandler: completion)
    }
    
    func userPasswordEdit(
        params: DSModels.Api.User.EditUserPasswordRequest,
        completion: @escaping (AFDataResponse<DSModels.Api.User.EditUserPasswordResponse>) -> Void
    ) {
        let requestEndpoint = DSEndpoints.User.EditUserPassword(params: params)
        request(request: requestEndpoint, completionHandler: completion)
    }
}
