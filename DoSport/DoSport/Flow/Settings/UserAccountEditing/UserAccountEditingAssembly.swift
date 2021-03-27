//
//  UserAccountEditingAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import Foundation

final class UserAccountEditingAssembly: Assembly {
    
    func makeModule() -> UserAccountEditingController {
        let requestsManager = RequestsManager.shared
        let viewModel = UserAccountEditingViewModelImplementation(requestsManager: requestsManager)
        let viewController = UserAccountEditingController(viewModel: viewModel)
        return viewController
    }
}
