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
    
    init(navController: UINavigationController) {
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
        coordiator.start()
    }
    
    func goToCountryListModule(compilation: @escaping (String) -> Swift.Void) {
        let coordinator = CountryListCoordinator(navController: navigationController, compilation: compilation)
        coordinator.start()
    }
    
    func goToPasswordEntryModule() {
        let coordinator = PasswordEntryCoordinator(navController: self.navigationController)
        coordinator.start()
    }
    
    func go() {
        
    }
}
