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
    
    init() {
        let assembly = AuthAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = DSNavigationController()
        self.navigationController?.navigationBar.barTintColor = Colors.darkBlue
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
    
    func goToCodeEntryModule() {
        let coordiator = CodeEntryCoordinator(navController: navigationController)
        coordiator.start()
    }
    
    func goToCountryListModule(compilation: @escaping (String) -> Swift.Void) {
        let coordinator = CountryListCoordinator(navController: navigationController, compilation: compilation)
        coordinator.start()
    }
}
