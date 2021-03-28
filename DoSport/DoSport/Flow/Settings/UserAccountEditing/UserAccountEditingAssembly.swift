//
//  UserAccountEditingAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import Foundation

final class UserAccountEditingAssembly: Assembly {
    
    func makeModule() -> UserAccountEditingController {
        let viewModel = UserProfileEditingViewModel()
        let viewController = UserAccountEditingController(viewModel: viewModel)
        return viewController
    }
}
