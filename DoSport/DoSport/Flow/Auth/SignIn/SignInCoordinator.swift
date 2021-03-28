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
    private var rootViewController: SingInViewController?
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        self.navigationController = navController
    }
    
    func start() {
        let assembly = SignInAssembly(coordinator: self)
        self.rootViewController = assembly.makeModule()
        
        guard let _ = self.rootViewController else { return }
        
        navigationController?.setViewControllers([self.rootViewController!], animated: true)
    }
    
    func startModally() {
        let assembly = SignInAssembly(coordinator: self)
        self.rootViewController = assembly.makeModule()
        
        guard let _ = self.rootViewController else { return }
        
        self.navigationController?.present(self.rootViewController!, animated: true, completion: nil)
    }
    
    func goToRegistrationModule() {
        let coordinator = SignUpCoordinator(navController: navigationController)
        coordinator.start()
    }
    
    func goToFeedModule() {
        let coordinator = MainTabBarCoordinator(navController: navigationController)
        coordinator.start()
    }
    func goToMainTabBar() {
        let coordinator = MainTabBarCoordinator(navController: self.navigationController)
        coordinator.start()
    }
    func openVkAuthView() {
        let vc = WKWebViewController()
        navigationController?.present(vc, animated: true, completion: nil)
    }
}
