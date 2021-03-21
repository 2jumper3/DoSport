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
        case getProfileByID(Int)
        case getPreferredSportTypes
        case editPreferredSportTypes
        case editPreferredSportTypeByID(Int)
        case deletePreferredSportTypeByID(Int)
        case getSubscribers
        case getSubscriptions
        case addSubscriptionByID(Int)
        case deleteSubscriptionByID(Int)
        
        var path: String {
            switch self {
            case .getProfile: return "profiles"
            case .editProfile: return "profiles"
            case .deleteProfile: return "profiles"
            case .getProfileByID(let id): return "profiles/\(id)"
            case .getPreferredSportTypes: return "profiles/sports"
            case .editPreferredSportTypes: return "profiles/sports"
            case .editPreferredSportTypeByID(let id): return "profiles/sports/\(id)"
            case .deletePreferredSportTypeByID(let id): return "profiles/sports/\(id)"
            case .getSubscribers: return "profiles/subscribers"
            case .getSubscriptions: return "profiles/subscriptions"
            case .addSubscriptionByID(_): return "profiles/subscriptions"
            case .deleteSubscriptionByID(_): return "profiles/subscriptions"
            }
        }
    }
}
