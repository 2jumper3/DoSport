//
//  SignUpCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit

final class SignUpCoordinator: Coordinator {
    
    var rootViewController: SignUpViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = SignUpAssembly()
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
        let sportTypeNetworkService = SportTypeNetworkService()
        let userNetworkService = UserNetworkService()
        let model = SportTypeGrid()
        let viewModel = SportTypeGridViewModel(
            sportTypeNetworkService: sportTypeNetworkService,
            userNetworkService: userNetworkService,
            model: model
        )
        
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

