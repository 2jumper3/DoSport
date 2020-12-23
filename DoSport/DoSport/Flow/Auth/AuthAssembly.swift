//
//  AuthAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

final class AuthAssembly: Assembly {
    
    func makeModule() -> AuthViewController {
        let viewModel = AuthViewModel()
        let viewController = AuthViewController(viewModel: viewModel)
        return viewController
    }
}
