//
//  SportTypeRequests.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension RequestsManager {
    
    //MARK: GET
    
    func sportTypesGet(
        params: DSModels.Api.SportType.SportTypeRequest,
        compilation: @escaping (DataHandler<[DSModels.Api.SportType.SportTypeResponse]>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.GetSportTypes()
        request(endpoint: endpoint, compilation: compilation)
    }
    
    func sportTypeGetById(
        params: DSModels.Api.SportType.SportTypeIDRequest,
        compilation: @escaping (DataHandler<DSModels.Api.SportType.SportTypeResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.GetSportTypeById(modelParams: params)
        request(endpoint: endpoint, compilation: compilation)
    }
    
    //MARK: CREATE
    
    func sportTypeCreate(
        params: DSModels.Api.SportType.SportTypeCreateRequest,
        compilation: @escaping (DataHandler<DSModels.Api.SportType.SportTypeEmptyResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.CreateSportType(modelParams: params)
        request(endpoint: endpoint, compilation: compilation)
    }
    
    //MARK: DELETE
    
    func sportTypeDelete(
        params: DSModels.Api.SportType.SportTypeIDRequest,
        compilation: @escaping (DataHandler<DSModels.Api.SportType.SportTypeEmptyResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.DeleteSportType(modelParams: params)
        request(endpoint: endpoint, compilation: compilation)
    }
    
    //MARK: PUT
    
    func sportTypePut(
        params: DSModels.Api.SportType.SportTypePutRequest,
        compilation: @escaping (DataHandler<DSModels.Api.SportType.SportTypeResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.PutSportType(modelParams: params)
        request(endpoint: endpoint, compilation: compilation)
    }
}
