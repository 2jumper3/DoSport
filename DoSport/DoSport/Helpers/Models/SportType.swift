//
//  SportType.swift
//  DoSport
//
//  Created by MAC on 17.01.2021.
//

import Foundation

enum SportType: String, CustomStringConvertible {
    case football
    case basketball
    case hockey
    case volleyball
    case tennis
    case workout
    case run
    case gym
    case yoga
    case box
    case group
    case dance
    case tabletennis
    case skateboard
    case badminton

    var description: String {
        switch self {
        case .football:
            return "Футбол"
        case .basketball:
            return "Баскетбол"
        case .hockey:
            return "Хоккей"
        case .volleyball:
            return "Волейбол"
        case .tennis:
            return "Теннис"
        case .workout:
            return "Воркаут"
        case .run:
            return "Бег"
        case .gym:
            return "Тренажерный\nзал"
        case .yoga:
            return "Йога"
        case .box:
            return "Бокс"
        case .group:
            return "Групповые\nтренировки"
        case .dance:
            return "Танцы"
        case .tabletennis:
            return "Настольный\nтеннис"
        case .skateboard:
            return "Скейборд"
        case .badminton:
            return "Бадминтон"
        }
    }
}
