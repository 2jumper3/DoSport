//
//  DSEnums+UserMainContentType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 24/03/2021.
//

import Foundation

extension DSEnums {
    
    enum UserMainContentType {
        case events
        case sportGrounds
        
        var index: Int {
            switch self {
            case .events: return 0
            case .sportGrounds: return 1
            }
        }
        
        var label: String {
            switch self {
            case .events: return "Тренировки"
            case .sportGrounds: return "Площадки"
            }
        }
    }
}
