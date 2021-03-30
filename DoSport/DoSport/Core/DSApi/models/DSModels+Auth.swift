//
//  DSModels+Api+Auth.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

/// Models with `CodingKeys` that used as params for requests

extension DSModels {
    enum Auth {
        
        // This struct is used for test sign in request
        struct SignInRequest: Codable {
            let username: String
            let password: String
        }
        
        // This struct is used for test sign in response
        struct SignInResponse: Codable {
            let token: String?
        }
        
        // This struct is used for test sign up request
        struct SignUpRequest: Codable {
            let username: String
            let password: String
            let passwordConfirm: String
        }
    }
}
