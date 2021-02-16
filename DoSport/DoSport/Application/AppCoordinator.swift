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
    var isAuthorised = false
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if isAuthorised {
            let navigationController = DSNavigationController()
            let coordinator = FeedCoordinator(navController: navigationController)
            coordinator.start()
        } else {
            let myCoordinator = OnBoardingCoordinator()
            myCoordinator.start()
            window.rootViewController = myCoordinator.navigationController
        }
    }
}
