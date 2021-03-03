//
//  DSEnums.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 02/03/2021.
//

import Foundation

enum DSMainContentType {
    case sportGrounds
    case events
    
    var label: String {
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

enum DSFeedEventSortType: String, CaseIterable, Codable {
    case all = "All"
    
    case subscribes = "Subscribes"
    case subscribers = "Subscribers"
    
    /// Default sort type configuration
    var defaultConfig: [DSFeedEventSortType] {
        [.all, .subscribes]
    }
    
    var label: String {
        switch self {
        case .all: return "All"
        case .subscribes: return "Subscribes"
        case .subscribers: return "Subscribers"
        }
    }
    
    var index: Int {
        switch self {
        case .all: return 0
        case .subscribes: return 1
        case .subscribers: return 2
        }
    }
}
