//
//  MainSportTypeSelectionCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/03/2021.
//

import UIKit

final class MainSportTypeSelectionCoordinator: Coordinator {
    
    let rootViewController: MainSportTypeSelectionController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let viewModel = MainSportTypeSelectionViewModel()
        self.rootViewController = MainSportTypeSelectionController(viewModel: viewModel)
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
    
    func goToMainSportGroundListModule() {
        
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
