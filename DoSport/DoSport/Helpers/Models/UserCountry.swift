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
    
    enum Keys: String, CodingKey {
        case name = "name"
        case collingCode = "dual_code"
        case code = "code"
    }
}
