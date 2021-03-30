//
//  SignInAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import Foundation

/// Describes object that creates AuthModule by injecting all needed dependencies to viewController
final class SignInAssembly: Assembly {
    
    /// Creates SingInViewController object with injected dependencies
    ///
    /// - Returns: created  object of SingInViewController class with all injected dependencies
    func makeModule() -> SingInViewController {
        let viewModel = SignInViewModel(dependencies: SignInServiceContainer())
        let viewController = SingInViewController(viewModel: viewModel)
        return viewController
    }
}

/// Sevices used by Auth model wrapped into one type
typealias SignInServices = HasUserNetworkService & HasAuthNetworkService & HasUserAccountService

/// Sevices used by Auth model wrapped into one container
final class SignInServiceContainer: SignInServices {
    
    var userAccountService: UserAccountServiceProtocol {
        return UserAccountService()
    }
    
    var userNetworkService: UserNetworkServiceProtocol {
        return UserNetworkService()
    }
    
    var authNetworkService: AuthNetworkServiceProtocol {
        return AuthNetworkService()
    }
}
