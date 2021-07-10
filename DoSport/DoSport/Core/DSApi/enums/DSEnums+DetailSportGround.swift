//
//  DSEnums+DetailSportGround.swift
//  DoSport
//
//  Created by Sergey on 31.05.2021.
//

import Foundation


extension DSEnums {
    
    enum DetailSportGround {
        case info
        case events
        case subscribers
        
        var title: String {
            switch self {
            case .info: return "Информация"
            case .events: return "Тренировки"
            case .subscribers: return "Подписчики"
            }
        }
        
        var index: Int {
            switch self {
            case .info: return 0
            case .events: return 1
            case .subscribers: return 2
            }
        }
        
    }
}
