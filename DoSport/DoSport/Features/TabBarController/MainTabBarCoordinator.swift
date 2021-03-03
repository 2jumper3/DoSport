//
//  MainTabBarCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/02/2021.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {
    
    var rootViewController: MainMenuTabController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        self.navigationController = navController
        self.rootViewController = MainMenuTabController()
    }
    
    func start() {
        rootViewController.coordinator = self
        rootViewController.setupTabBarViewControllers()
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
}
