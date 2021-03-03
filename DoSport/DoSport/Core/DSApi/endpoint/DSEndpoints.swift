//
//  DSEndpoints.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 02/03/2021.
//

import Foundation
import Alamofire

/// Endpoints used to build final request
enum DSEndpoints {
    
    //MARK: - Authentification -
    
    enum Authentification {
        
        struct Login: RequestRouter {
            let method: HTTPMethod = .post
            let path: String = "auth/login"
            let params: DSModels.Api.Auth.LoginRequest
            
            var parameters: Parameters? {
                return [
                    "email": params.email,
                    "password": params.password,
                ]
            }
        }
        
        struct Register: RequestRouter {
            let method: HTTPMethod = .post
            let path: String = "auth/register"
            let params: DSModels.Api.Auth.RegisterRequest
            
            var parameters: Parameters? {
                return [
                    "email": params.email,
                    "password": params.passwordConfirm,
                    "passwordConfirm": params.username,
                    "username": params.gender
                ]
            }
        }
    }
    
    //MARK: - User -
    
    enum User {
        
        struct GetUserProfile: RequestRouter {
            var method: HTTPMethod = .get
            var path: String = "profile"
            var parameters: Parameters?
        }
        
        struct GetUserProfileById: RequestRouter {
            var method: HTTPMethod = .get
            var path: String = "profile"
            var params: DSModels.Api.User.GetUserProfileById
            
            var parameters: Parameters? {
                return [
                    "id": params.id
                ]
            }
        }
        
        struct EditUserPassword: RequestRouter {
            var method: HTTPMethod = .patch
            var path: String = "profile/password"
            var params: DSModels.Api.User.EditUserPasswordRequest
            
            var parameters: Parameters? {
                return [
                    "newPassword": params.newPassword,
                    "newPasswordConfirm": params.newPasswordConfirm,
                    "oldPassword": params.oldPassword
                ]
            }
        }
        
        struct EditUserProfile: RequestRouter {
            var method: HTTPMethod = .patch
            var path: String = "profile"
            var params: DSModels.Api.User.EditUserProfile
            
            var parameters: Parameters? {
                return [
                    "birthdayDate": params.birthdayDate,
                    "gender": params.gender,
                    "hideBirthdayDate": params.isBirthdayDateHidden,
                    "id": params.id,
                    "photoLink": params.avatarPhoto,
                    "username": params.username
                ]
            }
        }
    }
    
    //MARK: - SportGround -
    
    enum SportGround {
        
        struct GetSportGroundsByCity: RequestRouter {
            var method: HTTPMethod = .get
            var path: String = "sportgrounds"
            var params: DSModels.Api.SportGround.SportGroundRequest
            
            var parameters: Parameters? {
                return [
                    "city": params.city
                ]
            }
        }
    }
}
