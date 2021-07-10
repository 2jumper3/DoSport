//
//  SportGroundDetailAssembly.swift
//  DoSport
//
//  Created by Sergey on 28.05.2021.
//

import Foundation

final class SportGroundDetailAssembly: Assembly {
    
    private let sportGround: DSModels.SportGround.SportGroundResponse
    
    init(sportGround: DSModels.SportGround.SportGroundResponse) {
        self.sportGround = sportGround
    }
    
    func makeModule() -> SportGroundDetailViewController {
        let userNetworkService = UserNetworkService()
        let viewModel = SportGroundDetailViewModel(userNetworkService: userNetworkService)
        let viewController = SportGroundDetailViewController(sportGround: sportGround, contentType: .info, viewModel: viewModel)
        return viewController
    }
}
