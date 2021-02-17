//
//  SportTypeGridCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class SportTypeGridCoordinator: Coordinator {
    
    var rootViewController: SportTypeGridViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = SportTypeGridAssembly()
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
    
    func goToFeedModule() {
        navigationController?.viewControllers = [MainMenuTabController()]
    }
}
