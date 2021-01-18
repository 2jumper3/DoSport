//
//  SportTypeListCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class SportTypeListCoordinator: Coordinator {
    
    var rootViewController: SportTypeListViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = SportTypeListAssembly()
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
    
    func goToHomeModule() {
        let coordinator = HomeCoordinator(navController: navigationController)
        coordinator.start()
    }
}
