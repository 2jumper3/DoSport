//
//  DSEndpoints+User.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSEndpoints {
    
    enum User: Endpoint {
        // User profile
        case getProfile
        case editProfile
        case deleteProfile
        case getProfileByID(Int)
        
        // User events
        case getUserOwnedEvents(byUserID: Int)
        case getUserParticipatingEvents
        
        // User preferred sport types
        case getPreferredSportTypes
        case editPreferredSportTypes
        case addPreferredSportTypeByID(DSModels.SportType.SportTypeByIDRequest)
        case deletePreferredSportTypeByID(DSModels.SportType.SportTypeByIDRequest)
        
        // User subscribers and subscriptions
        case getSubscribers
        case getSubscriptions
        case addSubscriptionByID(Int)
        case deleteSubscriptionByID(Int)
        
        //MARK: - Path -
        
        var path: String {
            switch self {
            case .getProfileByID(let id): return "profiles/\(id)"
                
            case .getUserOwnedEvents:         return "events"
            case .getUserParticipatingEvents: return "profiles/events"
                
            case .getPreferredSportTypes:                      return "profiles/sports"
            case .editPreferredSportTypes:                     return "profiles/sports"
            case .addPreferredSportTypeByID(let sportType):    return "profiles/sports/\(sportType.id)"
            case .deletePreferredSportTypeByID(let sportType): return "profiles/sports/\(sportType.id)"
                
            case .getSubscribers:                 return "profiles/subscribers"
            case .getSubscriptions:               return "profiles/subscriptions"
            case .addSubscriptionByID(let id):    return "profiles/subscriptions/\(id)"
            case .deleteSubscriptionByID(let id): return "profiles/subscriptions/\(id)"
                
            default: return "profiles"
            }
        }
        
        //MARK: - QueryItems -
        
        var queryItems: QueryItems? {
            switch self {
            case .getUserOwnedEvents(byUserID: let id):
                return [
                    "fromDate": "",
                    "organizerId": "\(id)",
                    "sportGroundId": "",
                    "sportTypeId": "",
                    "toDate": ""
                ]
            default: return nil
            }
        }
        
        //MARK: - HTTPMethod -

        var method: HTTPMethod {
            switch self {
            case .editProfile:                  return .put
            case .deleteProfile:                return .delete
            case .editPreferredSportTypes:      return .put
            case .addPreferredSportTypeByID:    return .put
            case .deletePreferredSportTypeByID: return .delete
            case .addSubscriptionByID:          return .put
            case .deleteSubscriptionByID:       return .delete
            default:                            return .get
            }
        }
    }
}
