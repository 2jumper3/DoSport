//
//  FeedBackCoordinator.swift
//  DoSport
//
//  Created by Dmitrii Diadiushkin on 31.05.2021.
//

import UIKit

final class FeedBackCoordinator: Coordinator {
    
    let rootViewController: FeedBackViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = FeedBackAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goBack() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
