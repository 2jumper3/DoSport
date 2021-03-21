//
//  DSModels+Api+User.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSModels {
    enum User {
        
        //MARK: - GET UserProfile -
        
        struct UserProfileRequest: Codable { }
        
        struct UserProfileResponse: Codable, Identifiable {
            let id: Int?
            let username: String?
            let avatarPhoto: String?
            let birthdayDate: String?
            let gender: String?
            let info: String?
            
            enum CodingKeys: String, CodingKey {
                case id, username
                case avatarPhoto = "photoLink"
                case birthdayDate, gender, info
            }
        }
        
        struct GetUserProfileById: Codable {
            let id: Int
        }
        
        //MARK: - EDIT UserProfile -
        
        struct EditUserProfile: Codable, Identifiable {
            let id: Int
            let username: String
            let avatarPhoto: String
            let birthdayDate: String
            let gender: String
            let info: String
            
            enum CodingKeys: String, CodingKey {
                case id, username
                case avatarPhoto = "photoLink"
                case birthdayDate, gender, info
            }
        }
        
        //MARK: - DELETE UserProfile -
        
        struct UserDeleteProfileResponse: Codable { }
        
        //MARK: 
        
    }
}
