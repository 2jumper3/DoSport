//
//  Event.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/01/2021.
//

import Foundation

struct Event: Codable {
    
    enum Hour: String, CaseIterable {
        case am7am8 = "07:00-08:00"
        case am8am9 = "08:00-09:00"
        case am9am10 = "09:00-10:00"
        case am10am11 = "10:00-11:00"
        case am11pm12 = "11:00-12:00"
        case pm12pm8 = "12:00-13:00"
        case pm1pm2 = "13:00-14:00"
        case pm2pm3 = "14:00-15:00"
        case pm3pm4 = "15:00-16:00"
        case pm4pm5 = "16:00-17:00"
        case pm5pm6 = "17:00-18:00"
        case pm6pm7 = "18:00-19:00"
        case pm7pm8 = "19:00-20:00"
        case pm8pm9 = "20:00-21:00"
        case pm9pm10 = "21:00-22:00"
        case pm10pm11 = "22:00-23:00"
        case pm11pm12 = "23:00-24:00"
        case pm12am1 = "24:00-01:00"
        case am1am2 = "01:00-02:00"
        case am2am3 = "02:00-03:00"
        case am3am4 = "03:00-04:00"
        case am4am5 = "04:00-05:00"
        case am5am6 = "05:00-07:00"
        case am6am7 = "06:00-07:00"
    }
    
    var eventID: Int?
    var eventDate: Date?
    var eventEndTime: Date?
    var eventStartTime: Date?
    var organiserID: Int?
    var chatID: Chat?
    var members: [Participants]?
    var sportGroundID: Int?
    var sportType: Sport?
}

extension Event.Hour: Codable { }
