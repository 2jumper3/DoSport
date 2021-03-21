//
//  DSEndpoints+SportType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSEndpoints {
    
    enum SportType: Endpoint {
        case getSportTypes
        case getSportTypeById(Int)
        case createSportType(title: String)
        case deleteSportType(usingID: Int)
        case putSportTypeByID(Int)
        
        //MARK: - Path -
        
        var path: String {
            switch self {
            case .getSportTypeById(let ID):         return "sporttype/\(ID)"
            case .deleteSportType(usingID: let ID): return "sporttype/\(ID)"
            case .putSportTypeByID(let ID):         return "sporttype/\(ID)"
            default:                                return "sporttype"
            }
        }
        
        //MARK: - ParameterEncoding -
        
        var parameterEncoding: ParameterEncoding {
            switch self {
            case .getSportTypes:    return .urlEncoding
            case .getSportTypeById: return .urlEncoding
            default:                return .jsonEncoding
            }
        }
        
        //MARK: - HTTPMethod -
        
        var method: HTTPMethod {
            switch self {
            case .createSportType: return .post
            case .putSportTypeByID:    return .put
            case .deleteSportType: return .delete
            default:               return .get
            }
        }
    }
}
