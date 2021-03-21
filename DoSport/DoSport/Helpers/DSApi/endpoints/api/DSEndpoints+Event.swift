//
//  DSEndpoints+Event.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSEndpoints {
    
    enum Event: Endpoint {
        case getEvents
        case createEvent(DSModels.Event.CreateEventRequest)
        case getEventsByParams(DSModels.Event.GetEventsByParameters)
        case getMembersOfEvent(eventID: Int)
        case addMemberToEvent(eventID: Int)
        case getMemberOfEvent(eventID: Int, userID: Int)
        case deleteMemberFromEvent(eventID: Int, userID: Int)
        case getEventComments(eventID: Int)
        case addEventComment(eventID: Int, eventComment: DSModels.Event.CreateEventCommentRequest)
        case editEventComment(eventID: Int, commentID: Int, comment: DSModels.Event.EditEventCommentRequest)
        case deleteEventComment(eventID: Int, commentID: Int)
        case getEventById(eventID: Int)
        case editEvent(eventID: Int, DSModels.Event.EditEventRequest)
        case deleteEvent(eventID: Int)
        case getEventsOfCurrentUser
        case getEventsWhereCurrentUserIsMember(userID: Int)
        
        //MARK: - Path -

        var path: String {
            switch self {
            case .getMembersOfEvent(let eventID):                  return "events/\(eventID)/members"
            case .addMemberToEvent(let eventID):                   return "events/\(eventID)/members"
            case .getMemberOfEvent(let eventID, let userID):       return "events/\(eventID)/members/\(userID)"
            case .deleteMemberFromEvent(let eventID, let userID):  return "events/\(eventID)/members/\(userID)"
            case .getEventComments(let eventID):                   return "events/\(eventID)/messages"
            case .addEventComment(let eventID, _):                 return "events/\(eventID)/messages"
            case .editEventComment(let eventID, let commentID, _): return "events/\(eventID)/messages/\(commentID)"
            case .deleteEventComment(let eventID, let commentID):  return "events/\(eventID)/messages/\(commentID)"
            case .getEventById(let eventID):                       return "events/\(eventID)"
            case .editEvent(let eventID, _):                       return "events/\(eventID)"
            case .deleteEvent(let eventID):                        return "events/\(eventID)"
            case .getEventsOfCurrentUser:                          return "events/calendar"
            case .getEventsWhereCurrentUserIsMember(let userID):   return "events/members/\(userID)"
            default:                                               return "events"
            }
        }
        
        //MARK: - ParameterObject -

        var parameters: ParameterObject? {
            switch self {
            case .createEvent(let event):             return event
            case .addEventComment(_, let comment):    return comment
            case .editEventComment(_,_, let comment): return comment
            case .editEvent(_, let event):            return event
            default:                                  return nil
            }
        }
        
        //MARK: - QueryItems -
        
        var queryItems: QueryItems? {
            switch self {
            case .getEventsByParams(let params):
                return [
                    "fromDate": params.fromDate ?? "",
                    "organiserId": params.organiserID ?? "",
                    "sportTypeId": params.sportTypeID ?? "",
                    "sportTypeId": params.sportTypeID ?? "",
                    "toDate": params.toDate ?? ""
                ]
            default: return nil
            }
        }
        
        //MARK: - ParameterEncoding -

        var parameterEncoding: ParameterEncoding {
            switch self {
            case .createEvent:           return .jsonEncoding
            case .addMemberToEvent:      return .jsonEncoding
            case .deleteMemberFromEvent: return .jsonEncoding
            case .addEventComment:       return .jsonEncoding
            case .editEventComment:      return .jsonEncoding
            case .deleteEventComment:    return .jsonEncoding
            case .editEvent:             return .jsonEncoding
            case .deleteEvent:           return .jsonEncoding
            default:                     return .urlEncoding
            }
        }
        
        //MARK: - HTTPMethod -

        var method: HTTPMethod {
            switch self {
            case .createEvent:           return .post
            case .addMemberToEvent:      return .post
            case .deleteMemberFromEvent: return .delete
            case .addEventComment:       return .post
            case .editEventComment:      return .delete
            case .deleteEventComment:    return .delete
            case .editEvent:             return .put
            case .deleteEvent:           return .delete
            default:                     return .get
            }
        }
    }
}
