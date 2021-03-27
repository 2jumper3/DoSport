//
//  AuthAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import Foundation

/// Describes object that creates AuthModule by injecting all needed dependencies to viewController
final class AuthAssembly: Assembly {
    
    /// Creates AuthViewController object with injected dependencies
    ///
    /// - Returns: created  object of AuthViewController class with all injected dependencies
    func makeModule() -> AuthViewController {
        let dependencies = (UserAccountService() & UserNetworkService() & AuthNetworkService())
        let viewModel = AuthViewModel(dependencies: dependencies)
        let viewController = AuthViewController(viewModel: viewModel)
        return viewController
    }
}
