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
        case putSportType(usingTitle: String, andID: Int)
        
        //MARK: - Path -
        
        var path: String {
            switch self {
            case .getSportTypeById(let ID):         return "sporttype/\(ID)"
            case .deleteSportType(usingID: let ID): return "sporttype/\(ID)"
            case .putSportType(_, let ID):          return "sporttype/\(ID)"
            default:                                return "sporttype"
            }
        }
        
        //MARK: - ParameterObject -
        
        var parameters: ParameterObject? {
            switch self {
            case .createSportType(let title): return title
            case .putSportType(let title, _): return title
            default:                          return nil
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
            case .putSportType:    return .put
            case .deleteSportType: return .delete
            default:               return .get
            }
        }
    }
}
