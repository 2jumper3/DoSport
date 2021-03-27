//
//  DSEnums+UserSubscribersContentType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 24/03/2021.
//

import Foundation

extension DSEnums {
    
    enum UserSubscribersContentType {
        case subscribers
        case subscriptions
        
        var index: Int {
            switch self {
            case .subscribers: return 0
            case .subscriptions: return 1
            }
        }
        
        var label: String {
            switch self {
            case .subscribers: return "Подписчики"
            case .subscriptions: return "Подписки"
            }
        }
    }
}
