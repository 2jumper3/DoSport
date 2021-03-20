//
//  DSEndpoints+Event.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSEndpoints {
    
    enum Event {
//        case getEvents
//        case createEvent(DSModels.Event.CreateEventRequest)
//        case getEventsByParams(DSEnums.EventsByParameter)
//        case getMembersOfEvent(eventID: Int)
//        case addMemberToEvent(eventID: Int)
//        case getMemberOfEvent(eventID: Int, userID: Int)
//        case deleteMemberFromEvent(eventID: Int, userID: Int)
//        case getEventComments(eventID: Int)
//        case addEventComment(eventID: Int)
//        case editEventComment(eventID: Int, commentID: Int)
//        case deleteEventComment(eventID: Int, commentID: Int)
//        case getEventById(eventID: Int)
//        case editEvent(eventID: Int)
//        case deleteEvent(eventID: Int)
//        case getEventsOfCurrentUser
//        case getEventsWhereCurrentUserIsMember(userID: Int)
//
//        var path: String {
//            switch self {
//            case .getEvents: return "events"
//            case .createEvent: return "events"
//            case .getEventsByParams: return "events/"
//            case .getMembersOfEvent(let eventID): return "events/\(eventID)/members"
//            case .addMemberToEvent(let eventID): return "events/\(eventID)/members"
//            case .getMemberOfEvent(let eventID, let userID): return "events/\(eventID)/members/\(userID)"
//            case .deleteMemberFromEvent(let eventID, let userID): return "events/\(eventID)/members/\(userID)"
//            case .getEventComments(let eventID): return "events/\(eventID)/messages"
//            case .addEventComment(let eventID): return "events/\(eventID)/messages"
//            case .editEventComment(let eventID, let commentID): return "events/\(eventID)/messages/\(commentID)"
//            case .deleteEventComment(let eventID, let commentID): return "events/\(eventID)/messages/\(commentID)"
//            case .getEventById(let eventID): return "events/\(eventID)"
//            case .editEvent(let eventID): return "events/\(eventID)"
//            case .deleteEvent(let eventID): return "events/\(eventID)"
//            case .getEventsOfCurrentUser: return "events/calendar"
//            case .getEventsWhereCurrentUserIsMember(let userID): return "events/members/\(userID)"
//            }
//        }
//
//        var parameters: ParameterObject? {
//            switch self {
//            case .getEvents: return nil
//            case .createEvent(let event): return event
//            case .getEventsByParams(let params): return params
//            case .getMembersOfEvent(eventID: let eventID):
//                <#code#>
//            case .addMemberToEvent:
//                <#code#>
//            case .getMemberOfEvent:
//                <#code#>
//            case .deleteMemberFromEvent:
//                <#code#>
//            case .getEventComments:
//                <#code#>
//            case .addEventComment:
//                <#code#>
//            case .editEventComment:
//                <#code#>
//            case .deleteEventComment:
//                <#code#>
//            case .getEventById:
//                <#code#>
//            case .editEvent:
//                <#code#>
//            case .deleteEvent:
//                <#code#>
//            case .getEventsOfCurrentUser:
//                <#code#>
//            case .getEventsWhereCurrentUserIsMember:
//                <#code#>
//            }
//        }
//
//        var parameterEncoding: ParameterEncoding {
//            switch self {
//
//            }
//        }
//
//        var method: HTTPMethod {
//            switch self {
//
//            }
//        }
//
        struct GetEvents: Endpoint {
            var method: HTTPMethod = .get
            var path: String = "events"
        }
    }
}
