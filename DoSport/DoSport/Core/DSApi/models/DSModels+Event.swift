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
            
            enum Hour: String, CaseIterable {
                case am7am8 = "07:00-08:00"
                case am8am9 = "08:00-09:00"
                case am9am10 = "09:00-10:00"
                case am10am11 = "10:00-11:00"
                case am11pm12 = "11:00-12:00"
                case pm12pm8 = "12:00-13:00"
                case pm1pm2 = "13:00-14:00"
                case pm2pm3 = "14:00-15:00"
                case pm3pm4 = "15:00-16:00"
                case pm4pm5 = "16:00-17:00"
                case pm5pm6 = "17:00-18:00"
                case pm6pm7 = "18:00-19:00"
                case pm7pm8 = "19:00-20:00"
                case pm8pm9 = "20:00-21:00"
                case pm9pm10 = "21:00-22:00"
                case pm10pm11 = "22:00-23:00"
                case pm11pm12 = "23:00-24:00"
                case pm12am1 = "24:00-01:00"
                case am1am2 = "01:00-02:00"
                case am2am3 = "02:00-03:00"
                case am3am4 = "03:00-04:00"
                case am4am5 = "04:00-05:00"
                case am5am6 = "05:00-07:00"
                case am6am7 = "06:00-07:00"
            }
            
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

