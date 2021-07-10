//
//  SportGroundDetailCoordinator.swift
//  DoSport
//
//  Created by Sergey on 28.05.2021.
//

import UIKit

final class SportGroundDetailCoordinator: Coordinator {
    
    let rootViewController: SportGroundDetailViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(
        navController: UINavigationController?,
        sportGround: DSModels.SportGround.SportGroundResponse?,
        contentType: DSEnums.DetailSportGround
    ) {
        let userNetworkService = UserNetworkService()
        let viewModel = SportGroundDetailViewModel(userNetworkService: userNetworkService)
        
        self.rootViewController = SportGroundDetailViewController(
            sportGround: sportGround,
            contentType: contentType,
            viewModel: viewModel
        )
        
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
}
