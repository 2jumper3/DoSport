//
//  DSEndpoints+SportGround.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSEndpoints {
    enum SportGround: Endpoint {
    //SportGround
        case getSportGrounds
        case getSportGroundByID(Int)
        
        var path: String {
            switch self {
            case .getSportGrounds:
                return "sportgrounds"
            case .getSportGroundByID(let id):
                return "sportgrounds/\(id)"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .getSportGrounds:  return .get
            case .getSportGroundByID: return .get
            }
        }
}
}
