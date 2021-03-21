//
//  DSModels+Api+Event.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSModels {
    enum Event {
        
        // MARK: - Get events
        
        struct GetEventsRequest: Codable {
            
        }
        
        struct GetEventsResponse: Codable {
            let creationDateTime: String?
            let eventID: Int?
            let startDateTime, endDateTime: String?
            let sportType: DSModels.SportType.SportTypeView?
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
        
        struct GetEventsByParameters: Codable {
            let fromDate: String?
            let organiserID: Int?
            let sportGroundID: Int?
            let sportTypeID: Int?
            let toDate: String?
            
            enum CodingKeys: String, CodingKey {
                case fromDate
                case organiserID = "organiserId"
                case sportGroundID = "sportGroundId"
                case sportTypeID = "sportTypeId"
                case toDate
            }
        }
        
        //MARK: - Create event
        
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
        
        //MARK: - Edit event
        
        struct EditEventRequest: Codable {
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
        
        //MARK: Delete event
        
        struct DeleteEventRequest: Codable {
            let id: Int
        }
        
        struct DeleteEventResponse: Codable { }
        
        //MARK: - Create comment
        
        struct CreateEventCommentRequest: Codable {
            let text: String
        }
        
        //MARK: - Edit comment
        
        struct EditEventCommentRequest: Codable {
            let text: String
        }
        
        struct EventCommentResponse: Codable {
            let messageID: Int?
            let eventID: Int?
            let userID: Int?
            let username: String?
            let userPhoto: String?
            let text: String?
            
            enum CodingKeys: String, CodingKey {
                case messageID = "messageId"
                case eventID = "eventId"
                case userID = "userId"
                case username
                case userPhoto = "photoLink"
                case text
            }
        }
    }
}

