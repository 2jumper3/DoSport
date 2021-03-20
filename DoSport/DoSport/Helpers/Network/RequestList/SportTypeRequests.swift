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
        let endpoint = DSEndpoints.SportType.getSportTypes
        request(endpoint: endpoint, compilation: compilation)
    }
    
    func sportTypeGetById(
        params: DSModels.Api.SportType.SportTypeIDRequest,
        compilation: @escaping (DataHandler<DSModels.Api.SportType.SportTypeResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.getSportTypeById(params.id)
        request(endpoint: endpoint, compilation: compilation)
    }
    
    //MARK: CREATE
    
    func sportTypeCreate(
        params: DSModels.Api.SportType.SportTypeCreateRequest,
        compilation: @escaping (DataHandler<DSModels.Api.SportType.SportTypeEmptyResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.createSportType(title: params.sportTitle)
        request(endpoint: endpoint, compilation: compilation)
    }
    
    //MARK: DELETE
    
    func sportTypeDelete(
        params: DSModels.Api.SportType.SportTypeIDRequest,
        compilation: @escaping (DataHandler<DSModels.Api.SportType.SportTypeEmptyResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.deleteSportType(usingID: params.id)
        request(endpoint: endpoint, compilation: compilation)
    }
    
    //MARK: PUT
    
    func sportTypePut(
        params: DSModels.Api.SportType.SportTypePutRequest,
        compilation: @escaping (DataHandler<DSModels.Api.SportType.SportTypeResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.putSportType(usingTitle: params.title, andID: params.sportTypeID)
        request(endpoint: endpoint, compilation: compilation)
    }
}
