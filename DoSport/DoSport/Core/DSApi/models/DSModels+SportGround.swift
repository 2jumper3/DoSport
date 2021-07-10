//
//  DSModels+Api+SportGround.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSModels {
    enum SportGround {
        
        //MARK: - GET SportGroundsByCity -
        
//        struct SportGroundRequest: Codable {
//            let city: String
//        }
        
        /// This struct is used as response object in `SportGround` requests if needed. Also this struct must be used in UI layer
        struct SportGroundResponse: Codable {
            let sportGroundId: Int?
            let city: String?
            let address: String?
            let title: String?
            let latitude: Double?
            let longitude: Double?
            let metroStation: String?
            let surfaceType: String
            let rentPrice: Int?
            let opened: Bool?
            let infrastructures: [String]?
            let sportTypes: [String]?//[Sport.SportType]
            let subscribers: [DSModels.User.UserView]?
            let reviews: [String]? ///`MISTAKE`
            let events: [DSModels.Event.EventView]?
            let openingTime: String?
            let closedTime: String?
            
            enum CodingKeys: String, CodingKey {
                case sportGroundId
                case city
                case address
                case title
                case latitude
                case longitude
                case metroStation
                case surfaceType
                case rentPrice
                case opened
                case infrastructures
                case sportTypes
                case subscribers
                case reviews
                case events
                case openingTime
                case closedTime
                
            }
            
        }
        struct SportGroundByIdRequest: Codable {
            let id: Int
            
            enum CodingKeys: String, CodingKey {
                case id = "sportGroundId"
            }
        }
        
    }
}
