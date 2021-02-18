//
//  MapFilterCoordinator.swift
//  DoSport
//
//  Created by Sergey on 18.02.2021.
//

import UIKit

class MapFilterCoordinator: Coordinator {
    var rootViewController: MapFilterViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController) {
        let assembly = MapFilterAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.viewControllers = [rootViewController]
    }
    func goToFilterViewController(navController: UINavigationController) {
        
    }
}
