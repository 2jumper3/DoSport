//
//  AuthAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import Foundation

final class AuthAssembly: Assembly {
    
    func makeModule() -> AuthViewController {
        let viewModel = AuthViewModel()
        let viewController = AuthViewController(viewModel: viewModel)
        return viewController
    }
}
