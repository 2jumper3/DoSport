//
//  UserRequests.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/03/2021.
//

import Foundation

extension RequestsManager {
    
    func getProfile(
        completion: @escaping (DataHandler<[DSModels.User.UserProfileResponse]>) -> Void
    ) {
        let endpoint = DSEndpoints.User.getProfile
        request(endpoint: endpoint, compilation: completion)
    }
    
    
}
