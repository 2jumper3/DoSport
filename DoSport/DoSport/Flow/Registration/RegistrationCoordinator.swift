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
    
    func goToFeedModule() {
        let coordinator = MainTabBarCoordinator(navController: navigationController)
        self.store(coordinator: coordinator)
        coordinator.start()
    }
    
    func goToSportTypeListModule(completion: @escaping () -> Swift.Void) {
        let requestManager = RequestsManager.shared
        let viewModel = SportTypeGridViewModelImplementation(requestManager: requestManager)
        let vc = SportTypeGridViewController(
            viewModel: viewModel,
            goBackCompletion: completion
        )
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func closeSportTypeGridModule() {
        self.navigationController?.dismiss(animated: true) {
            self.goToFeedModule()
        }
    }
}

