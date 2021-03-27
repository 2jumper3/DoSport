//
//  SportTypeNetworkService.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/03/2021.
//

import Foundation

final class SportTypeNetworkService {
    
    private let networkManager: NetworkManager = NetworkManagerImplementation.shared
    
    //MARK: GET
    
    func sportTypesGet(
        compilation: @escaping (DataHandler<[DSModels.SportType.SportTypeView]>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.getSportTypes
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: compilation)
    }
    
    func sportTypeGetById(
        params: DSModels.SportType.SportTypeByIDRequest,
        compilation: @escaping (DataHandler<DSModels.SportType.SportTypeView>) -> Swift.Void
    ) {
        let endpoint = DSEndpoints.SportType.getSportTypeById(params.id)
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
