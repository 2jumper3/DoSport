//
//  AuthCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

final class AuthCoordinator: Coordinator {
    
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
    
    func goToCodeEntryModule(_ phoneNumber: String) {
        let coordiator = CodeEntryCoordinator(navController: navigationController, phoneNumber)
        self.store(coordinator: coordiator)
        coordiator.start()
    }
    
    func goToCountryListModule(compilation: @escaping (String) -> Swift.Void) {
        let coordinator = CountryCodeListCoordinator(navController: navigationController, compilation: compilation)
        self.store(coordinator: coordinator)
        coordinator.start()
    }
    
    func goToPasswordEntryModule() {
        let coordinator = PasswordEntryCoordinator(navController: self.navigationController)
        store(coordinator: coordinator)
        coordinator.start()
    }
    func goToMainTabBar() {
        let coordinator = MainTabBarCoordinator(navController: self.navigationController)
        self.store(coordinator: coordinator)
        coordinator.start()
    }
    func openVkAuthView() {
        let coordinator = WKWebViewController(navController: self.navigationController)
        self.store(coordinator: coordinator)
        coordinator.start()
    }
}
