//
//  DSModels+Api+User.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 02/03/2021.
//

import Foundation

extension DSModels.Api {
    
    enum User {
        
        //MARK: - GET UserProfile -
        
        struct UserProfileRequest: Codable { }
        
        struct UserProfileResponse: Codable, Identifiable {
            let id: Int
            let username: String
            let avatarPhoto: String
            let birthdayDate: String
            let gender: String
            let isBirthdayDateHidden: Bool
            
            enum CodingKeys: String, CodingKey {
                case id, username
                case avatarPhoto = "photoLink"
                case birthdayDate, gender
                case isBirthdayDateHidden = "hideBirthdayDate"
            }
        }
        
        //MARK: - GET UserProfileById -
        
        struct GetUserProfileById: Codable {
            let id: Int
        }
        
        //MARK: - EDIT UserPassword -
        
        struct EditUserPasswordRequest: Codable {
            let newPassword: String
            let newPasswordConfirm: String
            let oldPassword: String
        }
        
        struct EditUserPasswordResponse: Codable { }
        
        //MARK: - EDIT UserProfile -
        
        struct EditUserProfile: Codable, Identifiable {
            let id: Int
            let username: String
            let avatarPhoto: String
            let birthdayDate: String
            let gender: String
            let isBirthdayDateHidden: Bool
            
            enum CodingKeys: String, CodingKey {
                case id, username
                case avatarPhoto = "photoLink"
                case birthdayDate, gender
                case isBirthdayDateHidden = "hideBirthdayDate"
            }
        }
        
//        struct UserSportGroundResponse: Codable {
//            let sportGroundId: Int
//            let userId: Int
//        }
//
//        struct UserSportTypeResponse: Codable {
//            let userId: Int
//            let firstname: String
//            let level: Int
//            let sportType: String
//        }
    }
}
