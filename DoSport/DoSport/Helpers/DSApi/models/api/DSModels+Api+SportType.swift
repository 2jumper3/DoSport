//
//  DSModels+Api+SportType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSModels.Api {
    enum SportType {
        
        struct SportTypeRequest: Codable {
            
        }
        
        struct SportTypeResponse: Codable {
            let sportTypeID: Int
            let title: String

            enum CodingKeys: String, CodingKey {
                case sportTypeID = "sportTypeId"
                case title
            }
        }
    }
}


