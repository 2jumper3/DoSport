//
//  HomeCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    let rootViewController: HomeViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = HomeAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
}
