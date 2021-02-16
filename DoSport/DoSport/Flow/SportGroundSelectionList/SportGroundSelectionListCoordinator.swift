//
//  SportGroundSelectionListCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit

final class SportGroundSelectionListCoordinator: Coordinator {
    
    let rootViewController: SportGroundSelectionListViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(
        navController: UINavigationController?,
        sportTypeTitle: String,
        completion: @escaping (String) -> Void
    ) {
        let assembly = SportGroundSelectionListAssembly(
            sportTypeTitle: sportTypeTitle,
            completion: completion
        )
        
        self.rootViewController = assembly.makeModule()
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

