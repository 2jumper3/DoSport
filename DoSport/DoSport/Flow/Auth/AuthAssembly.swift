//
//  AuthAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import Foundation

@available(iOS 13.0, *)
final class AuthAssembly: Assembly {
    
    func makeModule() -> AuthViewController {
        let viewModel = AuthViewModel()
        let viewController: AuthViewController
        
        let authManeger: AuthManagerProtocol = AuthManager()
        viewController = AuthViewController(viewModel: viewModel, authManeger: authManeger)
        
        return viewController
    }
}
