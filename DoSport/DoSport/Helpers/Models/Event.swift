//
//  Event.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/01/2021.
//

import Foundation

struct Event: Codable {
    
    var eventID: Int64?
    var eventDate: Date?
    var eventEndTime: Date?
    var eventStartTime: Date?
    var organiserID: Int64?
    var chatID: Int64?
    var members: [Member]?
    var sportGroundID: Int64?
    var sportType: Sport? 
}
