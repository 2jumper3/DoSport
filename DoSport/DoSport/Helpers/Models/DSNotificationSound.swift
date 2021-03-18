//
//  DSNotificationSound.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import Foundation

struct DSNotificationSound {
    
    enum NotificationSoundType: String, CaseIterable {
        case nota, echoPulse, bamboo, chord, rings, ending, hello, entering, keyboards, popcorn, pulse, synthesizer
        
        var title: String {
            switch self {
            case .nota: return "Нота"
            case .echoPulse: return "Эхо-Импульс"
            case .bamboo: return "Бамбук"
            case .chord: return "Аккорд"
            case .rings: return "Кольца"
            case .ending: return "Завершение"
            case .hello: return "Привет"
            case .entering: return "Вход"
            case .keyboards: return "Клавиши"
            case .popcorn: return "Попкорн"
            case .pulse: return "Импульс"
            case .synthesizer: return "Синтезатор"
            }
        }
    }
}
