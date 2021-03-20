//
//  DSEndpoints+SportType.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension DSEndpoints {
    enum SportType {
        
        struct GetSportTypes: Endpoint {
            var path: String = "sporttype"
        }
        
        struct GetSportTypeById: Endpoint {
            var path: String = "sporttype"
            var modelParams: DSModels.Api.SportType.SportTypeIDRequest
            
            var parameters: Parameters? {
                return [
                    "sportTitle": modelParams.id
                ]
            }
        }
        
        struct CreateSportType: Endpoint {
            var method: HTTPMethod = .post
            var path: String = "sporttype"
            var modelParams: DSModels.Api.SportType.SportTypeCreateRequest
            var parameterEncoding: ParameterEncoding = .jsonEncoding
            
            var parameters: Parameters? {
                return [
                    "title": modelParams.sportTitle
                ]
            }
        }
        
        struct DeleteSportType: Endpoint {
            var method: HTTPMethod = .delete
            var path: String = "sporttype"
            var modelParams: DSModels.Api.SportType.SportTypeIDRequest
            var parameterEncoding: ParameterEncoding = .jsonEncoding
            
            var parameters: Parameters? {
                return [
                    "id": modelParams.id
                ]
            }
        }
        
        struct PutSportType: Endpoint {
            var method: HTTPMethod = .put
            var path: String = "sporttype"
            var modelParams: DSModels.Api.SportType.SportTypePutRequest
            var parameterEncoding: ParameterEncoding = .jsonEncoding
            
            var parameters: Parameters? {
                return [
                    "id": modelParams.sportTypeID,
                    "title": modelParams.title
                ]
            }
        }
    }
}
