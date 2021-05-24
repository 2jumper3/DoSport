//
//  User.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 06/02/2021.
//

import Foundation

struct User: Codable {
    let id: Int?
    let name: String?
}

extension User: Equatable {
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name
    }
}

extension User: Hashable {
  
    func hash(into hasher: inout Hasher) {
        
    }
}
