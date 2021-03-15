//
//  RegistrationCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit

final class RegistrationCoordinator: Coordinator {
    
    var rootViewController: RegistrationViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = RegistrationAssembly()
        self.navigationController = navController
        self.rootViewController = assembly.makeModule()
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goToSportTypeListModule() {
        let coordinator = SportTypeGridCoordinator(navController: self.navigationController)
        self.store(coordinator: coordinator)
        coordinator.start()
    }
}

