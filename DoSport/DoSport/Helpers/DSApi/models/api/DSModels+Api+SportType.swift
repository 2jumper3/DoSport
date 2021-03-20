//
//  DSModels+Api+SportType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSModels.Api {
    
    enum SportType {
        
        //MARK: - GET
        
        struct SportTypeRequest: Codable {
            
        }
        
        struct SportTypeResponse: Codable, Equatable {
            let sportTypeID: Int?
            let title: String?

            enum CodingKeys: String, CodingKey {
                case sportTypeID = "sportTypeId"
                case title
            }
        }
        
        //MARK: - Create
        
        struct SportTypeCreateRequest: Codable {
            let sportTitle: String
        }
        
        //MARK: - Delete/Get by ID
        
        struct SportTypeIDRequest: Codable {
            let id: Int
        }
        
        struct SportTypeEmptyResponse: Codable { }
        
        //MARK: - Put
        
        struct SportTypePutRequest: Codable {
            let sportTypeID: Int
            let title: String

            enum CodingKeys: String, CodingKey {
                case sportTypeID = "sportTypeId"
                case title
            }
        }
        
        struct SportTypePutResponse: Codable, Equatable {
            let sportTypeID: Int?
            let title: String?

            enum CodingKeys: String, CodingKey {
                case sportTypeID = "sportTypeId"
                case title
            }
        }
    }
}


