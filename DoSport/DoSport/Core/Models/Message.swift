//
//  Message.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import Foundation

struct Message: Codable {
    
    let eventId: Int64?
    let id: Int64?
    let text: String?
    let userId: Int64?
    let userName: String?
    let createdDate: Date?
}
