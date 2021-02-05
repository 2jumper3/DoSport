//
//  EventViewCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 05/02/2021.
//

import UIKit

final class EventViewCoordinator: Coordinator {
    
    let rootViewController: EventViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?, event: Event) {
        let assembly = EventViewAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
        rootViewController.viewModel.event = event
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
}
