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
        
        var path: String {
            switch self {
            case .getSportTypes: return "sporttype"
            case .getSportTypeById(let ID): return "sporttype/\(ID)"
            case .createSportType: return "sporttype"
            case .deleteSportType(usingID: let ID): return "sporttype/\(ID)"
            case .putSportType(_, let ID): return "sporttype/\(ID)"
            }
        }
        
        var parameters: ParameterObject? {
            switch self {
            case .getSportTypes: return nil
            case .getSportTypeById: return nil
            case .createSportType(let title): return title
            case .deleteSportType: return nil
            case .putSportType(let title, _): return title
            }
        }
        
        var parameterEncoding: ParameterEncoding {
            switch self {
            case .getSportTypes: return .urlEndoding
            case .getSportTypeById: return .urlEndoding
            case .createSportType: return .jsonEncoding
            case .deleteSportType: return .jsonEncoding
            case .putSportType: return .jsonEncoding
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .getSportTypes: return .get
            case .getSportTypeById: return .get
            case .createSportType: return .post
            case .putSportType: return .put
            case .deleteSportType: return .delete
            }
        }
    }
}
