//
//  DSModels+Api+Event.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSModels.Api {
    enum Event {
        
        // MARK: - Events -
        
        struct GetEventsRequest: Codable {
            
        }
        
        struct GetEventsResponse: Codable {
            let creationDateTime: String?
            let eventID: Int?
            let startDateTime, endDateTime: String?
            let sportType: DSModels.Api.SportType.SportTypeResponse?
            let sportGroundID, organizerID: Int?
            let members: [Member]?
            let description: String?
            let isPrivate: Bool?
            let price, maximumMembers: Int?

            enum CodingKeys: String, CodingKey {
                case creationDateTime
                case eventID = "eventId"
                case startDateTime, endDateTime, sportType
                case sportGroundID = "sportGroundId"
                case organizerID = "organizerId"
                case members, description, isPrivate, price, maximumMembers
            }
        }
        
        struct CreateEventRequest: Codable {
            let startDateTime, endDateTime, sportTypeTitle: String?
            let sportGroundID: Int?
            let description: String?
            let isPrivate: Bool?
            let price, maximumMembers: Int?
            
            enum CodingKeys: String, CodingKey {
                case startDateTime, endDateTime, sportTypeTitle
                case sportGroundID = "sportGroundId"
                case description, isPrivate, price, maximumMembers
            }
        }
        
        
    }
}

