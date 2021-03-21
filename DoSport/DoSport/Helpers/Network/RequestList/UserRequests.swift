//
//  UserRequests.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension RequestsManager {
    
    //MARK: - GET UserProfile -
    
    func userProfileGet(
        completion: @escaping (DataHandler<DSUserProfileResponses.UserProfileResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getProfile
        request(endpoint: endpoint, bodyObject: DSEmptyRequest?.none,         completion: completion)
    }
    
    func userProfileGetByID(
        params: DSUserProfileRequests.UserProfileById,
        completion: @escaping (DataHandler<DSUserProfileResponses.UserProfileResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getProfileByID(params)
        request(endpoint: endpoint, bodyObject: DSEmptyRequest?.none,         completion: completion)
    }
    
    //MARK: - EDIT UserProfile -
    
    func userProfileEdit(
        params: DSUserProfileRequests.UserProfileEdit,
        completion: @escaping (DataHandler<DSUserProfileResponses.UserProfileResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.editProfile
        request(
            endpoint: endpoint,
            bodyObject: params,
                    completion: completion
        )
    }
    
    //MARK: - DELETE UserProfile -
    
    func userProfileDelete(
        completion: @escaping (DataHandler<DSUserProfileResponses.UserProfileEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.deleteProfile
        request(endpoint: endpoint, bodyObject: DSEmptyRequest?.none,         completion: completion)
    }
    
    //MARK: - GET User sportTypes -
    
    func userPreferredSportTypesGet(
        completion: @escaping (DataHandler<[DSModels.SportType.SportTypeView]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getPreferredSportTypes
        request(endpoint: endpoint, bodyObject: DSEmptyRequest?.none,         completion: completion)
    }
    
    //MARK: - EDIT User sportTypes -
    
    func userPreferredSportTypesEdit(
        params: [DSModels.SportType.SportTypeView],
        completion: @escaping (DataHandler<[DSModels.SportType.SportTypeView]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.editPreferredSportTypes
        request(
            endpoint: endpoint,
            bodyObject: params,
                    completion: completion
        )
    }
    
    //MARK: - ADD User sportType -
    
    func userAddPreferredSportType(
        params: DSModels.SportType.SportTypeByIDRequest,
        completion: @escaping (DataHandler<DSModels.SportType.SportTypeEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.addPreferredSportTypeByID(params)
        request(endpoint: endpoint, bodyObject: DSEmptyRequest?.none,         completion: completion)
    }
    
    //MARK: - DELETE User sportType -
    
    func userDeletePreferredSportType(
        params: DSModels.SportType.SportTypeByIDRequest,
        completion: @escaping (DataHandler<DSModels.SportType.SportTypeEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.deletePreferredSportTypeByID(params)
        request(endpoint: endpoint, bodyObject: DSEmptyRequest?.none,         completion: completion)
    }
    
    //MARK: - GET User subscribers & subscriptions -
    
    func userGetSubscribers(
        completion: @escaping (DataHandler<[DSUserProfileResponses.UserProfileResponse]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getSubscribers
        request(endpoint: endpoint, bodyObject: DSEmptyRequest?.none,         completion: completion)
    }
    
    func userGetSubscriptions(
        completion: @escaping (DataHandler<[DSUserProfileResponses.UserProfileResponse]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getSubscriptions
        request(endpoint: endpoint, bodyObject: DSEmptyRequest?.none,         completion: completion)
    }
    
    //MARK: - ADD User subscription -
    
    func userAddSubscription(
        params: DSUserProfileRequests.UserProfileById,
        completion: @escaping (DataHandler<DSUserProfileResponses.UserProfileEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.addSubscriptionByID(params)
        request(endpoint: endpoint, bodyObject: DSEmptyRequest?.none,         completion: completion)
    }
    
    //MARK: - DELETE User subscription -
    
    func userDeleteSubscription(
        params: DSUserProfileRequests.UserProfileById,
        completion: @escaping (DataHandler<DSUserProfileResponses.UserProfileEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.deleteSubscriptionByID(params)
        request(endpoint: endpoint, bodyObject: DSEmptyRequest?.none,         completion: completion)
    }
}
