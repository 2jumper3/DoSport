//
//  DSModels+Api+Event.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSModels {
    
    enum Event {
        
        /// This struct is used as response object in `Event` requests if needed. Also this struct must be used in UI layer
        struct EventView: Codable {
            let creationDateTime: String?
            let eventID: Int?
            let startDateTime, endDateTime: String?
            let sportType: String? //DSModels.SportType.SportTypeView?
            let sportGroundID: Int?
            let organizer: Participants?
            let members: [Participants]?
            let description: String?
            let isPrivate: Bool?
            let price, maximumUsers: Int?
            let usersAmount: Int?
            let messagesAmount: Int?

            enum CodingKeys: String, CodingKey {
                case creationDateTime
                case eventID = "eventId"
                case startDateTime, endDateTime, sportType
                case sportGroundID = "sportGroundId"
                case organizer
                case description, isPrivate, price, maximumUsers
                case usersAmount, messagesAmount
                case members = "participants"
            }
        }
        
        /// This struct is used for GET by parameters for query items of url
        struct EventByParametersRequest: Codable {
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
        
        /// This struct is used for POST and PUT method requests as body object
        struct EventRequest: Codable {
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
        
        /// This struct is used to provide Event object's `id` property as path of url
        struct EventByIDRequest: Codable {
            let id: Int
        }
        
        /// This struct is used for empty object response if needed
        struct EventEmptyResponse: Codable { }
        
        /// This struct is used as response object for `EventComment` requests if needed. Also this struct must be used in UI layer
        struct EventCommentView: Codable {
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
        
        /// This struct is used to provide both Event and EventComment objects `id` property as path of url
        struct EventAndCommentByIDRequest: Codable {
            let commentID: Int
            let eventID: Int
        }
        
        /// This struct is used for PUT and POST methods of `EventComment` requests as body object
        struct EventCommentRequest: Codable {
            let text: String
        }
        
        /// This struct is used for empty object response if needed
        struct EventCommentEmptyResponse: Codable { }
    }
}

