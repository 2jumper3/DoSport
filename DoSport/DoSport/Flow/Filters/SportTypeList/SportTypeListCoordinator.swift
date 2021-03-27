//
//  SportTypeListCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class SportTypeListCoordinator: Coordinator {
    
    let rootViewController: SportTypeListViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?, completion: @escaping (String) -> Void) {
        self.rootViewController = SportTypeListViewController(completion: completion)
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
