//
//  DSModels+Api+User.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSModels {
    
    enum User {
        
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
        
        struct UserByIdRequest: Codable {
            let id: Int
        }
        
        struct UserEmptyResponse: Codable { }
    }
}
