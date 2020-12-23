//
//  AuthCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

final class AuthCoordinator: Coordinator {
    
    var rootViewController: AuthViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init() {
        let assembly = AuthAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = UINavigationController()
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.viewControllers = [rootViewController]
    }
}
