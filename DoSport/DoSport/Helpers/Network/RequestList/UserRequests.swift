//
//  UserRequests.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension RequestsManager {
    
    func userProfileGet(
        completion: @escaping (DataHandler<DSUserProfileResponses.UserProfileResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getProfile
        request(endpoint: endpoint, compilation: completion)
    }
    
    func userProfileEdit(
        params: DSUserProfileRequests.UserProfileEdit,
        completion: @escaping (DataHandler<DSUserProfileResponses.UserProfileResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.editProfile(params)
        request(endpoint: endpoint, compilation: completion)
    }
    
    func userProfileDelete(
        completion: @escaping (DataHandler<DSUserProfileResponses.UserProfileEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.deleteProfile
        request(endpoint: endpoint, compilation: completion)
    }
    
    func userProfileGetByID(
        params: DSUserProfileRequests.UserProfileById,
        completion: @escaping (DataHandler<DSUserProfileResponses.UserProfileResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getProfileByID(params)
        request(endpoint: endpoint, compilation: completion)
    }
    
    func userPreferredSportTypesGet(
        completion: @escaping (DataHandler<[DSSportTypeResponses.SportTypeResponse]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getPreferredSportTypes
        request(endpoint: endpoint, compilation: completion)
    }
    
    func userPreferredSportTypesEdit(
        params: [DSSportTypeRequests.SportTypePutRequest],
        completion: @escaping (DataHandler<[DSSportTypeResponses.SportTypeResponse]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.editPreferredSportTypes(params)
        request(endpoint: endpoint, compilation: completion)
    }
    
    func userAddPreferredSportType(
        params: DSSportTypeRequests.SportTypeByIDRequest,
        completion: @escaping (DataHandler<DSSportTypeResponses.SportTypeEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.addPreferredSportTypeByID(params)
        request(endpoint: endpoint, compilation: completion)
    }
    
    func userDeletePreferredSportType(
        params: DSSportTypeRequests.SportTypeByIDRequest,
        completion: @escaping (DataHandler<DSSportTypeResponses.SportTypeEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.deletePreferredSportTypeByID(params)
        request(endpoint: endpoint, compilation: completion)
    }
    
    func userGetSubscribers(
        completion: @escaping (DataHandler<[DSUserProfileResponses.UserProfileResponse]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getSubscribers
        request(endpoint: endpoint, compilation: completion)
    }
    
    func userGetSubscriptions(
        completion: @escaping (DataHandler<[DSUserProfileResponses.UserProfileResponse]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getSubscriptions
        request(endpoint: endpoint, compilation: completion)
    }
    
    func userAddSubscription(
        params: DSUserProfileRequests.UserProfileById,
        completion: @escaping (DataHandler<DSUserProfileResponses.UserProfileEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.addSubscriptionByID(params)
        request(endpoint: endpoint, compilation: completion)
    }
    
    func userDeleteSubscription(
        params: DSUserProfileRequests.UserProfileById,
        completion: @escaping (DataHandler<DSUserProfileResponses.UserProfileEmptyResponse>) -> Void
    ) {
        let endpoint = DSEndpoints.User.deleteSubscriptionByID(params)
        request(endpoint: endpoint, compilation: completion)
    }
}
