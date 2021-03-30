//
//  DSEnums+MainContentType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSEnums {
    
    enum MainContentType {
        case sportGrounds
        case events
        
        var title: String {
            switch self {
            case .sportGrounds: return "Площадки"
            case .events: return "Тренировки"
            }
        }
        
        var index: Int {
            switch self {
            case .sportGrounds: return 0
            case .events: return 1
            }
        }
    }
}
