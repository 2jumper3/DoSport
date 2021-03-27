//
//  SportGround.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import Foundation

struct SportGround: Codable {
    let sportGroudID: Int?
    let title: String?
    let address: String?
    let city: String?
    let events: [Event]?
    let lattitude: Double?
    let longitude: Double?
    let sportTypes: [Sport.SportType]?
}
