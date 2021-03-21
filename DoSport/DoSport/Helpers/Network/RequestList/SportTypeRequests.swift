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
        params: DSSportTypeRequests.SportTypeRequest,
        compilation: @escaping (DataHandler<[DSSportTypeResponses.SportTypeResponse]>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.getSportTypes
        request(endpoint: endpoint, compilation: compilation)
    }
    
    func sportTypeGetById(
        params: DSSportTypeRequests.SportTypeByIDRequest,
        compilation: @escaping (DataHandler<DSSportTypeResponses.SportTypeResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.getSportTypeById(params)
        request(endpoint: endpoint, compilation: compilation)
    }
    
    //MARK: CREATE
    
    func sportTypeCreate(
        params: DSSportTypeRequests.SportTypeCreateRequest,
        compilation: @escaping (DataHandler<DSSportTypeResponses.SportTypeEmptyResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.createSportType(params)
        request(endpoint: endpoint, compilation: compilation)
    }
    
    //MARK: DELETE
    
    func sportTypeDelete(
        params: DSSportTypeRequests.SportTypeDeleteRequest,
        compilation: @escaping (DataHandler<DSSportTypeResponses.SportTypeEmptyResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.deleteSportType(params)
        request(endpoint: endpoint, compilation: compilation)
    }
    
    //MARK: PUT
    
    func sportTypePut(
        params: DSSportTypeRequests.SportTypePutRequest,
        compilation: @escaping (DataHandler<DSSportTypeResponses.SportTypeResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.putSportType(params)
        request(endpoint: endpoint, compilation: compilation)
    }
}
