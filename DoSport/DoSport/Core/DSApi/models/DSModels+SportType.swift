//
//  DSModels+Api+SportType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSModels {
    
    enum SportType {
        
        /// This struct is used as response object in `SportType` requests if needed. Also this struct must be used in UI layer
        struct SportTypeView: Codable, Equatable {
            let id: Int?
            let title: String?

            enum CodingKeys: String, CodingKey {
                case id = "sportTypeId"
                case title
            }
        }
        
        /// This struct is used to provide SportType object's `id` property is required as path in url
        struct SportTypeByIDRequest: Codable {
            let id: Int
            
            enum CodingKeys: String, CodingKey {
                case id = "sportTypeId"
            }
        }
        
        /// Use this struct's `sportTitle` value only for POST requests as body object.
        /// Remember, that you need to send only `String` value while createing SportType.
        struct SportTypeCreateRequest: Codable {
            let sportTitle: String
        }

        /// This struct is used for empty object response if needed
        struct SportTypeEmptyResponse: Codable { }
    }
}


