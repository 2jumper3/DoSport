//
//  SportGroundDetailAssembly.swift
//  DoSport
//
//  Created by Sergey on 28.05.2021.
//

import Foundation

final class SportGroundDetailAssembly: Assembly {
    
    func makeModule() -> SportGroundDetailViewController {
        let userNetworkService = UserNetworkService()
        let viewModel = SportGroundDetailViewModel(userNetworkService: userNetworkService)
        let viewController = SportGroundDetailViewController(
            viewModel: viewModel
        )
        return viewController
    }
}
