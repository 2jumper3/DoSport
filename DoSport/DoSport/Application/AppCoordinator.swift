//
//  AppCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let windowScene: UIWindowScene
    
    var navigationController: UINavigationController?
    
    private let userAccountService: UserAccountServiceProtocol = UserAccountService()
    
    init(window: UIWindow, windowScene: UIWindowScene) {
        self.window = window
        self.windowScene = windowScene
        self.navigationController = DSNavigationController()
    }
    
    func start() {
        let coordinator: Coordinator
      
        if userAccountService.isAuthorised {
            coordinator = MainTabBarCoordinator(navController: self.navigationController)
            coordinator.start()
        } else {
            coordinator = OnBoardingCoordinator(navController: self.navigationController)
            coordinator.start()
        }
        
        self.window.windowScene = self.windowScene
        self.window.rootViewController = coordinator.navigationController
        self.window.makeKeyAndVisible()
    }
}
