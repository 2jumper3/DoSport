//
//  UserMainCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 26/02/2021.
//

import UIKit

final class UserMainCoordinator: Coordinator {
    
    let rootViewController: UserMainController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?, user: User? = User(id: 1, name: "Kamol")) {
        let assembly = UserMainAssembly(user: user)
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goToUserSubscribtionListModule(_ contentType: DSEnums.UserSubscribersContentType, with user: User?) {
        let coodinator = UserSubscriberListCoordinator(
            navController: navigationController,
            user: user,
            contentType: contentType
        )
        store(coordinator: coodinator)
        coodinator.start()
    }
    
    func goToSettingsMainListModule() {
        let coordinator = SettingsCoordinator(navController: navigationController)
        store(coordinator: coordinator)
        coordinator.start()
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
