//
//  UserAccountEditingAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import Foundation

final class UserAccountEditingAssembly: Assembly {
    
    func makeModule() -> UserAccountEditingController {
        let serviceContainer = UserAccountEditingServiceContainer()
        let viewModel = UserProfileEditingViewModel(dependencies: serviceContainer)
        let viewController = UserAccountEditingController(viewModel: viewModel)
        return viewController
    }
}

/// Sevices used by UserAccountEditing module wrapped into one type
typealias UserAccountEditingServices = HasUserNetworkService & HasUserAccountService

/// Sevices used by UserAccountEditing module wrapped into one container
final class UserAccountEditingServiceContainer: UserAccountEditingServices {
    
    var userAccountService: UserAccountServiceProtocol {
        return UserAccountService()
    }
    
    var userNetworkService: UserNetworkServiceProtocol {
        return UserNetworkService()
    }
}
