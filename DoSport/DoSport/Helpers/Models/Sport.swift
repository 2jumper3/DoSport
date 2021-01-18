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
        case .basketball:
            title = type.rawValue
        case .hockey:
            title = type.rawValue
        case .volleyball:
            title = type.rawValue
        case .tennis:
            title = type.rawValue
        case .workout:
            title = type.rawValue
        case .run:
            title = type.rawValue
        case .gym:
            title = type.rawValue
        case .yoga:
            title = type.rawValue
        case .box:
            title = type.rawValue
        case .group:
            title = type.rawValue
        case .dance:
            title = type.rawValue
        case .tablettennis:
            title = type.rawValue
        case .skateboard:
            title = type.rawValue
        case .badminton:
            title = type.rawValue
        case .other:
            title = type.rawValue
        }
    }
    
    enum SportType: String, CaseIterable {
        case football = "Футбол"
        case basketball = "Баскетбол"
        case hockey = "Хоккей"
        case volleyball = "Волейбол"
        case tennis = "Теннис"
        case workout = "Воркоут"
        case run = "Бег"
        case gym = "Треножерный зал"
        case yoga = "Йога"
        case box = "Бокс"
        case group = "Групповое трени"
        case dance = "Танцы"
        case tablettennis = "Настольный теннис"
        case skateboard = "Скейтборд"
        case badminton = "Бадминтое"
        case other = "Другое"
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
