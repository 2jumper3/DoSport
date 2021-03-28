//
//  UserNetworkService.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/03/2021.
//

import Foundation

protocol HasUserNetworkService: class {
    var userNetworkService: UserNetworkServiceProtocol { get }
}

protocol UserNetworkServiceProtocol: class {
    func userProfileGet(
        completion: @escaping (DataHandler<DSModels.User.UserView>) -> Void)
    
    func userProfileEdit(
        params: DSModels.User.UserView,
        completion: @escaping (DataHandler<DSModels.User.UserView>) -> Void)
    
    func userProfileDelete(
        completion: @escaping (DataHandler<DSModels.User.UserEmptyResponse>) -> Void)
}

final class UserNetworkService: UserNetworkServiceProtocol {
    
    private let networkManager: NetworkManager = NetworkManagerImplementation.shared
    
    //MARK: - User Profile -
    
    func userProfileGet(
        completion: @escaping (DataHandler<DSModels.User.UserView>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getProfile
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    func userProfileGetByID(
        params: DSModels.User.UserByIdRequest,
        completion: @escaping (DataHandler<DSModels.User.UserView>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getProfileByID(params.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    func userProfileEdit(
        params: DSModels.User.UserView,
        completion: @escaping (DataHandler<DSModels.User.UserView>) -> Void
    ) {
        let endpoint = DSEndpoints.User.editProfile
        networkManager.makeRequest(
            endpoint: endpoint,
            bodyObject: params,
            completion: completion
        )
    }
    
    func userProfileDelete(
        completion: @escaping (DataHandler<DSModels.User.UserEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.deleteProfile
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    //MARK: - User SportTypes -
    
    func userPreferredSportTypesGet(
        completion: @escaping (DataHandler<[DSModels.SportType.SportTypeView]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getPreferredSportTypes
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    func userPreferredSportTypesEdit(
        params: [DSModels.SportType.SportTypeView],
        completion: @escaping (DataHandler<[DSModels.SportType.SportTypeView]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.editPreferredSportTypes
        networkManager.makeRequest(
            endpoint: endpoint,
            bodyObject: params,
            completion: completion
        )
    }
    
    func userAddPreferredSportType(
        params: DSModels.SportType.SportTypeByIDRequest,
        completion: @escaping (DataHandler<DSModels.SportType.SportTypeEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.addPreferredSportTypeByID(params)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    func userDeletePreferredSportType(
        params: DSModels.SportType.SportTypeByIDRequest,
        completion: @escaping (DataHandler<DSModels.SportType.SportTypeEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.deletePreferredSportTypeByID(params)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    //MARK: - User subscribers & subscriptions -
    
    func userGetSubscribers(
        completion: @escaping (DataHandler<[DSModels.User.UserView]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getSubscribers
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    func userGetSubscriptions(
        completion: @escaping (DataHandler<[DSModels.User.UserView]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getSubscriptions
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    
    func userAddSubscription(
        params: DSModels.User.UserByIdRequest,
        completion: @escaping (DataHandler<DSModels.User.UserEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.addSubscriptionByID(params.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    
    func userDeleteSubscription(
        params: DSModels.User.UserByIdRequest,
        completion: @escaping (DataHandler<DSModels.User.UserEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.deleteSubscriptionByID(params.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    //MARK: - User events -
    
    /// Gets events created by current user using his/her id
    ///
    /// - Parameters:
    ///     - queryItems:
    ///     - completion:
    func userGetOwnedEvents(
        queryItems: DSModels.User.UserByIdRequest,
        completion: @escaping (DataHandler<[DSModels.Event.EventView]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getUserOwnedEvents(byUserID: queryItems.id)
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }
    
    /// Gets events where current user is participating
    ///
    /// - Parameters:
    ///     - completion:
    func userGetParticipatingEvents(
        completion: @escaping (DataHandler<[DSModels.Event.EventView]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getUserParticipatingEvents
        networkManager.makeRequest(endpoint: endpoint, bodyObject: DSEmptyRequest?.none, completion: completion)
    }

}
