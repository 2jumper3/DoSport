//
//  DSModels+Api+SportGround.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 02/03/2021.
//

import Foundation

extension DSModels.Api {
    enum SportGround {
        
        //MARK: - GET SportGroundsByCity -
        
        struct SportGroundRequest: Codable {
            let city: String
        }
        
        struct SportGroundResponse: Codable {
            let title: String
            let address: String
            let city: String
            let events: [DSModels.Api.Event.EventResponse]
            let latitude: Double
            let longitude: Double
            let sportGroundId: Int
            let sportTypes: [Sport.SportType]
            let photo: String // needed to create in backend
            let isFree: Bool //  needed to create in backend
            let groundType: String 
        }
        
        
    }
}
