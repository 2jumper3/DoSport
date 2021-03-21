//
//  DSModels+Api+SportType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSModels {
    
    enum SportType {
        
        struct SportTypeView: Codable, Equatable {
            let id: Int?
            let title: String?

            enum CodingKeys: String, CodingKey {
                case id = "sportTypeId"
                case title
            }
        }
        
        struct SportTypeByIDRequest: Codable {
            let id: Int
            
            enum CodingKeys: String, CodingKey {
                case id = "sportTypeId"
            }
        }
        
        struct SportTypeCreateRequest: Codable {
            let sportTitle: String
        }

        struct SportTypeEmptyResponse: Codable { }
    }
}


