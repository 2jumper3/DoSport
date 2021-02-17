//
//  AppCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    // temprorary variable to immitate auth logic
    var isAuthorised = true
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = DSNavigationController()
    }
    
    func start() {
        let coordinator: Coordinator
        
        if isAuthorised {
            coordinator = MainTabBarCoordinator(navController: navigationController)
            self.store(coordinator: coordinator)
            coordinator.start()
        } else {
            coordinator = OnBoardingCoordinator(navController: self.navigationController)
            self.store(coordinator: coordinator)
            coordinator.start()
        }
        
        window.rootViewController = coordinator.navigationController
    }
}
