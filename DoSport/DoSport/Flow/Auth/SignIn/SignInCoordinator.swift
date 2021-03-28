//
//  SignInCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

/// Describes navigation & coordination of class that controlls Authentification screen.
final class SignInCoordinator: Coordinator {
    
    /// NavigationController's root viewController object .
    let rootViewController: SingInViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = SignInAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
    
    func startModally() {
        self.rootViewController.coordinator = self
        self.navigationController?.present(self.rootViewController, animated: true, completion: nil)
    }
    
    func goToRegistrationModule() {
        let coordinator = SignUpCoordinator(navController: navigationController)
        self.store(coordinator: coordinator)
        coordinator.start()
    }
    
    func goToFeedModule() {
        let coordinator = MainTabBarCoordinator(navController: navigationController)
        self.store(coordinator: coordinator)
        coordinator.start()
    }
    func goToMainTabBar() {
        let coordinator = MainTabBarCoordinator(navController: self.navigationController)
        store(coordinator: coordinator)
        coordinator.start()
    }
    func openVkAuthView() {
        let vc = WKWebViewController()
        navigationController?.present(vc, animated: true, completion: nil)
        
    }
}
