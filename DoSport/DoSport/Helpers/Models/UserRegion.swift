//
//  UserRegion.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import Foundation

struct UserRegion {
    let region: Region
    let code: RegionCode
}

enum RegionCode: Int, CaseIterable {
    case c_994 = 994
    
}

enum Region: String, CaseIterable {
    case australia
    case austria
    case azerbaijan
}
