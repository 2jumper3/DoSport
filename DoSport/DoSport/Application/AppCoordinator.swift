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
            // open main module.. code
        } else {
//            let vc = OnBoardingViewController()
//            window.rootViewController = vc
            
            let myCoordinator = AuthCoordinator()
            myCoordinator.start()
            window.rootViewController = myCoordinator.navigationController
        }
    }
}
