//
//  DSEndpoints+Event.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSEndpoints {
    
    enum Event: Endpoint {
        // Events
        case getEvents(DSModels.Event.EventByParametersRequest?)
        case createEvent
        case getEventByID(eventID: Int)
        case editEventByID(eventID: Int)
        case deleteEventByID(eventID: Int)
        
        // Event comments
        case getEventComments(eventID: Int)
        case addEventComment(eventID: Int)
        case editEventComment(eventID: Int, commentID: Int)
        case deleteEventComment(eventID: Int, commentID: Int)
        
        // Event members
        case getMembersByEventID(eventID: Int)
        case addMemberByEventID(eventID: Int)
        case deleteMemberByEventID(eventID: Int)
        case deleteMemberByEventAndMemberID(eventID: Int, userID: Int)
        
        //MARK: - Path -

        var path: String {
            switch self {
            // Events
            case .getEventByID(let eventID):    return "events/\(eventID)"
            case .editEventByID(let eventID):   return "events/\(eventID)"
            case .deleteEventByID(let eventID): return "events/\(eventID)"
                
            // Event comments
            case .getEventComments(let eventID):                  return "events/\(eventID)/messages"
            case .addEventComment(let eventID):                   return "events/\(eventID)/messages"
            case .editEventComment(let eventID, let commentID):   return "events/\(eventID)/messages/\(commentID)"
            case .deleteEventComment(let eventID, let commentID): return "events/\(eventID)/messages/\(commentID)"
                
            // Event members
            case .getMembersByEventID(let eventID):   return "events/\(eventID)/participants"
            case .addMemberByEventID(let eventID):    return "events/\(eventID)/participants"
            case .deleteMemberByEventID(let eventID): return "events/\(eventID)/participants"
            case .deleteMemberByEventAndMemberID(let eventID, let userID):
                return "events/\(eventID)/participants/\(userID)"
            
            default: return "events"
            }
        }
        
        //MARK: - QueryItems -
        
        var queryItems: QueryItems? {
            switch self {
            case .getEvents(let params):
                if let params = params {
                    return [
                        "fromDate":    params.fromDate ?? "",
                        "organiserId": params.organiserID ?? "",
                        "sportTypeId": params.sportTypeID ?? "",
                        "sportTypeId": params.sportTypeID ?? "",
                        "toDate":      params.toDate ?? ""
                    ]
                } else {
                    return nil
                }
            default: return nil
            }
        }
        
        //MARK: - HTTPMethod -

        var method: HTTPMethod {
            switch self {
            // Event
            case .createEvent:     return .post
            case .editEventByID:   return .put
            case .deleteEventByID: return .delete
                
            // Event members
            case .addMemberByEventID:             return .post
            case .deleteMemberByEventID:          return .delete
            case .deleteMemberByEventAndMemberID: return .delete
                
            // Event comments
            case .addEventComment:    return .post
            case .editEventComment:   return .put
            case .deleteEventComment: return .delete
                
            default: return .get
            }
        }
    }
}
