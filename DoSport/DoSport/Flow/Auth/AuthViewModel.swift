//
//  AuthViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import Foundation

final class AuthViewModel {
    
    var userRegions: [UserRegion] {
        var userRegion: [UserRegion] = []
        Region.allCases.forEach { region in
            RegionCode.allCases.forEach { regionCode in
                userRegion.append(UserRegion(region: region, code: regionCode))
            }
        }
        return userRegion
    }
    
    init() {
        
    }
    
}
