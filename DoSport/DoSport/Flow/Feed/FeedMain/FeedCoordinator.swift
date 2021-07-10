//
//  FeedCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class FeedCoordinator: Coordinator {
    
    let rootViewController: FeedViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = FeedAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
    
    func goToEventModule(withSelected event: DSModels.Event.EventView) {
        let coordinator = EventCoordinator(navController: navigationController, event: event)
        coordinator.start()
    }
    
    func goToEventCreateModule() {
        let coordinator = EventCreateCoordinator(navController: self.navigationController)
        coordinator.start()
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
