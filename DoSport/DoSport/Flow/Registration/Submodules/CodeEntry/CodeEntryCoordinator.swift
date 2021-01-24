//
//  CodeEntryCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/01/2021.
//

import UIKit

final class CodeEntryCoordinator: Coordinator {
    
    let rootViewController: CodeEntryViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?, _ phoneNumber: String) {
        let assembly = CodeEntryAssembly(phoneNumber)
        self.navigationController = navController
        self.rootViewController = assembly.makeModule()
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func goToRegistrationModule() {
        let coordinator = RegistrationCoordinator(navController: navigationController)
        coordinator.start()
    }
}
