//
//  AuthCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

/// Describes navigation & coordination of class that controlls Authentification screen.
final class AuthCoordinator: Coordinator {
    
    /// NavigationController's root viewController object .
    let rootViewController: AuthViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = AuthAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
    
    func goToRegistrationModule() {
        let coordinator = RegistrationCoordinator(navController: navigationController)
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
    func openVkAuthView(completion: @escaping() -> Void) {
        let vc = WKWebViewController(completion: completion)
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func dismissWKWebView()  {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
