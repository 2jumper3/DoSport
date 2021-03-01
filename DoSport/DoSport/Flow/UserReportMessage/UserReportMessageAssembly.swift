//
//  UserReportMessageAssembly.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import Foundation

final class UserReportMessageAssembly: Assembly {
    
    func makeModule() -> UserReportMessageController {
        let viewModel = UserReportMessageViewModel()
        let viewController = UserReportMessageController(viewModel: viewModel)
        return viewController
    }
}
