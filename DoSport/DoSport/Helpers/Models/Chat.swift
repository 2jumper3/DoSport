//
//  Chat.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 06/02/2021.
//

import Foundation

struct Chat: Codable {
    
    let ID: Int?
    let messages: [Message]?
    let userID: Int?
    let userName: Int?
}
