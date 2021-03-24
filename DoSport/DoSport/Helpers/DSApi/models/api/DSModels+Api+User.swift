//
//  DSModels+Api+User.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSModels {
    
    enum User {
        
        /// This struct is used as response object in `User` requests if needed. Also this struct must be used in UI layer
        struct UserView: Codable, Identifiable {
            let id: Int?
            let username: String?
            let avatarPhoto: Data?
            let birthdayDate: String?
            let gender: String?
            let info: String?
            
            enum CodingKeys: String, CodingKey {
                case id, username
                case avatarPhoto = "photoLink"
                case birthdayDate, gender, info
            }
        }
        
        /// This struct is used to provide User object's `id` property is required as path in url
        struct UserByIdRequest: Codable {
            let id: Int
        }
        
        /// This struct is used for empty object response if needed
        struct UserEmptyResponse: Codable { }
    }
}
