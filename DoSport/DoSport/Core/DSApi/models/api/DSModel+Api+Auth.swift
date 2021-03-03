//
//  DSModel+Api+Auth.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 03/03/2021.
//

import Foundation

/// Models with `CodingKeys` that used as params for requests

extension DSModels.Api {
    enum Auth {
        
        //MARK: -  Login -
        
        struct LoginRequest: Codable {
            let email: String
            let password: String
        }
        
        struct LoginResponse: Codable {
            let dsToken: String
            
            enum CodingKeys: String, CodingKey {
                case dsToken = "token"
            }
        }
        
        //MARK: - Register -
        
        struct RegisterRequest {
            let email: String
            let username: String
            let password: String
            let passwordConfirm: String
            let gender: String
            let birthdayDate: String?
            let avatarImage: String?
            
            enum CodingKeys: String, CodingKey {
                case username,
                     gender,
                     password,
                     passwordConfirm,
                     birthdayDate
                case avatarImage = "photoLink"
            }
        }
        
        struct RegisterResponse: Codable {
            let username: String
            let firstName: String
            let lastName: String
            let gender: String?
            let isBirthdayDateHidden: Bool
            let birthdayDate: String?
            let id: Int
            let info: String
            let avatarImage: String?
            
            enum CodingKeys: String, CodingKey {
                case username,
                     firstName,
                     lastName,
                     gender,
                     isBirthdayDateHidden,
                     birthdayDate,
                     id
                case info
                case avatarImage = "photoLink"
            }
        }
    }
}
