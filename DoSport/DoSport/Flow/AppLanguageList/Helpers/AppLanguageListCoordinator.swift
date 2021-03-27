//
//  AppLanguageListCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

/// Describes navigation & coordination of class that controlls App Language selection screen.
final class AppLanguageListCoordinator: Coordinator {
    
    let rootViewController: AppLanguageListController
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController?
    
    init(
        navController: UINavigationController?,
        compilation: @escaping (_ language: AppLanguageModel.Language) -> Swift.Void
    ) {
        let viewModel = AppLanguageViewModel()
        
        self.rootViewController = AppLanguageListController(
            viewModel: viewModel,
            compilation: compilation
        )
        
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
