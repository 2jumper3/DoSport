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
    
    init(navController: UINavigationController?) {
        let assembly = MapAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goToFilterViewController() {
        let coordinator = MapFilterCoordinator(navController: navigationController)
        self.store(coordinator: coordinator)
        coordinator.start()
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
