//
//  Sport.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import Foundation

struct Sport: Codable {
    
    var title: String?
    var icon: String?
    
    var type: SportType?
    
    init(type: SportType) {
        self.type = type

        switch type {
        case .football:
            title = type.rawValue
            icon = "\(type)"
        case .basketball:
            title = type.rawValue
            icon = "\(type)"
        case .hockey:
            title = type.rawValue
            icon = "\(type)"
        case .volleyball:
            title = type.rawValue
            icon = "\(type)"
        case .tennis:
            title = type.rawValue
            icon = "\(type)"
        case .workout:
            title = type.rawValue
            icon = "\(type)"
        case .run:
            title = type.rawValue
            icon = "\(type)"
        case .gym:
            title = type.rawValue
            icon = "\(type)"
        case .yoga:
            title = type.rawValue
            icon = "\(type)"
        case .box:
            title = type.rawValue
            icon = "\(type)"
        case .group:
            title = type.rawValue
            icon = "\(type)"
        case .dance:
            title = type.rawValue
            icon = "\(type)"
        case .tabletennis:
            title = type.rawValue
            icon = "\(type)"
        case .skateboard:
            title = type.rawValue
            icon = "\(type)"
        case .badminton:
            title = type.rawValue
            icon = "\(type)"
        case .other:
            title = type.rawValue
            icon = "\(type)"
        }
    }
    
    enum SportType: String, CaseIterable {
        case football = "Футбол"
        case basketball = "Баскетбол"
        case hockey = "Хоккей"
        case volleyball = "Волейбол"
        case tennis = "Теннис"
        case workout = "Воркаут"
        case run = "Бег"
        case gym = "Тренажерный зал"
        case yoga = "Йога"
        case box = "Бокс"
        case group = "Групповые тренировки"
        case dance = "Танцы"
        case tabletennis = "Настольный теннис"
        case skateboard = "Скейтборд"
        case badminton = "Бадминтон"
        case other = "Другое"
    }

    static func returnSportTypeModelsList() -> [Sport] {
        let typeOfSports = [
            Sport(type: .football),
            Sport(type: .basketball),
            Sport(type: .hockey),
            Sport(type: .volleyball),
            Sport(type: .tennis),
            Sport(type: .workout),
            Sport(type: .run),
            Sport(type: .gym),
            Sport(type: .yoga),
            Sport(type: .box),
            Sport(type: .group),
            Sport(type: .dance),
            Sport(type: .tabletennis),
            Sport(type: .skateboard),
            Sport(type: .badminton),
        ]

        return typeOfSports
    }
}

extension Sport.SportType: Codable { }

//MARK: - Equatable

extension Sport: Equatable {
    
    static func ==(lhs: Sport, rhs: Sport) -> Bool {
        return lhs.title == rhs.title &&
            lhs.icon == rhs.icon
    }
}
