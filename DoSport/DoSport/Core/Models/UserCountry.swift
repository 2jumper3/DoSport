//
//  UserCountry.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import Foundation

struct CountryList: Codable {
    let countries: [Country]?
}

struct Country: Codable {
    let name: String?
    let callingCode: String?
    let code: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case callingCode = "dial_code"
        case code = "code"
    }
}
