//
//  DSModels+Api+SportType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

typealias DSSportTypeRequests = DSModels.SportType.requests
typealias DSSportTypeResponses = DSModels.SportType.responses

extension DSModels {
    
    enum SportType {
        enum requests {
            //MARK: - GET
            
            struct SportTypeRequest: Codable { }
            
            struct SportTypeGetByIDRequest: Codable {
                let sportTypeID: Int
                
                enum CodingKeys: String, CodingKey {
                    case sportTypeID = "sportTypeId"
                }
            }
            
            //MARK: - Create
            
            struct SportTypeCreateRequest: Codable {
                let sportTitle: String
            }
            
            //MARK: - Delete
            
            struct SportTypeDeleteRequest: Codable {
                let sportTypeID: Int
                
                enum CodingKeys: String, CodingKey {
                    case sportTypeID = "sportTypeId"
                }
            }
            
            //MARK: - Put
            
            struct SportTypePutRequest: Codable {
                let sportTypeID: Int
                let title: String

                enum CodingKeys: String, CodingKey {
                    case sportTypeID = "sportTypeId"
                    case title
                }
            }
        }
        
        enum responses {
            struct SportTypeResponse: Codable, Equatable {
                let sportTypeID: Int?
                let title: String?

                enum CodingKeys: String, CodingKey {
                    case sportTypeID = "sportTypeId"
                    case title
                }
            }
            
            struct SportTypeEmptyResponse: Codable { }
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


