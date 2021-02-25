//
//  MapCoordinator.swift
//  DoSport
//
//  Created by Sergey on 17.01.2021.
//

import UIKit

class MapCoordinator: Coordinator {
    
    var rootViewController: MapViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController) {
        let assembly = MapAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.viewControllers = [rootViewController]
    }
    func goToFilterViewController() {
        let coordinator = MapFilterCoordinator(navController: self.navigationController)
        coordinator.start()
    }
}
