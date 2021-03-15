//
//  UserSubscriberListCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit

final class UserSubscriberListCoordinator: Coordinator {
    
    let rootViewController: UserSubscriberListController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?, user: User?, index: Int) {
        self.rootViewController = UserSubscriberListController(
            user: user,
            segmentedControlIndex: index
        )
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goToSelectedUserPageModule(with user: User?) {
        let coordinator = UserMainCoordinator(navController: navigationController, user: user)
        store(coordinator: coordinator)
        coordinator.start()
    }
}
