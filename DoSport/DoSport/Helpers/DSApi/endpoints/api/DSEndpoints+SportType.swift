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
        case getSportTypeById(DSSportTypeRequests.SportTypeByIDRequest)
        case createSportType(DSSportTypeRequests.SportTypeCreateRequest)
        case deleteSportType(DSSportTypeRequests.SportTypeDeleteRequest)
        case putSportType(DSSportTypeRequests.SportTypePutRequest)
        
        //MARK: - Path -
        
        var path: String {
            switch self {
            case .getSportTypeById(let sportType): return "sporttype/\(sportType.id)"
            case .deleteSportType(let sportType):  return "sporttype/\(sportType.id)"
            case .putSportType(let sportType):     return "sporttype/\(sportType.id)"
            default:                               return "sporttype"
            }
        }
        
        //MARK: - ParameterObject -
        
        var parameters: ParameterObject? {
            switch self {
            case .createSportType(let sportType): return sportType.sportTitle
            case .putSportType(let sportType):    return sportType.title
            default:                              return nil
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
