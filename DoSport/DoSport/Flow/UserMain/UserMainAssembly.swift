//
//  UserMainAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import Foundation

final class UserMainAssembly: Assembly {
    
    private let user: User?
    
    init(user: User?) {
        self.user = user
    }
    
    func makeModule() -> UserMainController {
        let viewModel = UserMainViewModel()
        let viewController = UserMainController(viewModel: viewModel, user: user)
        return viewController
    }
}
