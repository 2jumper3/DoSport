//
//  Member.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/01/2021.
//

import Foundation

struct Member: Codable {
    var userID: Int64?
    var eventID: Int64?
    var userStatus: String?
}

struct Participants: Codable {
    var id: Int?
    var username: String?
    var birthdayDate: String?
    var gender: String?
    var info: String?
    var photoLink: String?
}
