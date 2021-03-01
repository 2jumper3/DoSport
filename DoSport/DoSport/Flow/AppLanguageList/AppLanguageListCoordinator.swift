//
//  AppLanguageListCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

final class AppLanguageListCoordinator: Coordinator {
    
    let rootViewController: AppLanguageListController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?, compilation: @escaping (String) -> Swift.Void) {
        self.rootViewController = AppLanguageListController(compilation: compilation)
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
