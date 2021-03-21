//
//  DSEndpoints+User.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSEndpoints {
    
    enum User: Endpoint {
        case getProfile
        case editProfile
        case deleteProfile
        case getProfileByID(DSUserProfileRequests.UserProfileById)
        case getPreferredSportTypes
        case editPreferredSportTypes
        case addPreferredSportTypeByID(DSModels.SportType.SportTypeByIDRequest)
        case deletePreferredSportTypeByID(DSModels.SportType.SportTypeByIDRequest)
        case getSubscribers
        case getSubscriptions
        case addSubscriptionByID(DSUserProfileRequests.UserProfileById)
        case deleteSubscriptionByID(DSUserProfileRequests.UserProfileById)
        
        //MARK: - Path -
        
        var path: String {
            switch self {
            case .getProfileByID(let userProfile):             return "profiles/\(userProfile.id)"
            case .getPreferredSportTypes:                      return "profiles/sports"
            case .editPreferredSportTypes:                     return "profiles/sports"
            case .addPreferredSportTypeByID(let sportType):    return "profiles/sports/\(sportType.id)"
            case .deletePreferredSportTypeByID(let sportType): return "profiles/sports/\(sportType.id)"
            case .getSubscribers:                              return "profiles/subscribers"
            case .getSubscriptions:                            return "profiles/subscriptions"
            case .addSubscriptionByID(let user):               return "profiles/subscriptions/\(user.id)"
            case .deleteSubscriptionByID(let user):            return "profiles/subscriptions/\(user.id)"
            default:                                           return "profiles"
            }
        }
        
        //MARK: - ParameterEncoding -

        var parameterEncoding: ParameterEncoding {
            switch self {
            case .editProfile:             return .jsonEncoding
            case .editPreferredSportTypes: return .jsonEncoding
            default:                       return .urlEncoding
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
