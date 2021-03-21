//
//  DSModels+Api+User.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

typealias DSUserProfileRequests = DSModels.User.requests
typealias DSUserProfileResponses = DSModels.User.responses

extension DSModels {
    enum User {
        
        enum requests {
            
            //MARK: - GET UserProfile -
            
            struct UserProfile: Codable { }
            
            struct UserProfileById: Codable {
                let id: Int
            }
            
            //MARK: - EDIT UserProfile -
            
            struct UserProfileEdit: Codable, Identifiable {
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
            
            struct UserProfileDelete: Codable {
                let id: Int
            }
        }
        
        enum responses {
            
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
            
            struct UserProfileEmptyResponse: Codable { }
        }
    }
}
