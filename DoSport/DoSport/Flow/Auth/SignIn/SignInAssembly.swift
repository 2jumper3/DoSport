//
//  SignInAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import Foundation

/// Describes object that creates AuthModule by injecting all needed dependencies to viewController
final class SignInAssembly: Assembly {
    
    private let coordinator: SignInCoordinator
    
    init(coordinator: SignInCoordinator) {
        self.coordinator = coordinator
    }
    
    /// Creates SingInViewController object with injected dependencies
    ///
    /// - Returns: created  object of SingInViewController class with all injected dependencies
    func makeModule() -> SingInViewController {
        let accountService = UserAccountService()
        let userNetworkService = UserNetworkService()
        let authNetworkService = AuthNetworkService()
        let viewModel = SignInViewModel(
            coordinator: self.coordinator,
            authNetworkService: authNetworkService,
            userNetworkService: userNetworkService,
            userAccountService: accountService)
        let viewController = SingInViewController(viewModel: viewModel)
        return viewController
    }
}
