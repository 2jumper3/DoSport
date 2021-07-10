//
//  SportGroundNetworkService.swift
//  DoSport
//
//  Created by Sergey on 01.06.2021.
//

import Foundation

final class SportGroundNetworkService {
    
    private let networkManager: NetworkManager = NetworkManagerImplementation.shared
    
    //MARK: GET
    
    func sportGroundsGet(
        compilation: @escaping (DataHandler<[DSModels.SportGround.SportGroundResponse]>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportGround.getSportGrounds
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: compilation)
    }
    
    func sportGroundGetById(
        params: DSModels.SportGround.SportGroundByIdRequest,
        compilation: @escaping (DataHandler<DSModels.SportGround.SportGroundResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportGround.getSportGroundByID(params.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: compilation)
    }
    
    //MARK: CREATE
    
    func sportTypeCreate(
        params: DSModels.SportType.SportTypeCreateRequest,
        compilation: @escaping (DataHandler<DSModels.SportType.SportTypeEmptyResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.createSportType(title: params.sportTitle)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: params.sportTitle, completion: compilation)
    }
    
    //MARK: DELETE
    
    func sportTypeDelete(
        params: DSModels.SportType.SportTypeByIDRequest,
        compilation: @escaping (DataHandler<DSModels.SportType.SportTypeEmptyResponse>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.deleteSportType(usingID: params.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: compilation)
    }
    
    //MARK: PUT
    
    func sportTypePut(
        params: DSModels.SportType.SportTypeView,
        compilation: @escaping (DataHandler<DSModels.SportType.SportTypeEmptyResponse>) -> Swift.Void
    ) {
        guard let title = params.title, let id = params.id else { return }
        
        let endpoint = DSEndpoints.SportType.putSportTypeByID(id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: title, completion: compilation)
    }
}
