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
    
    init(navController: UINavigationController?) {
        let assembly = UserMainAssembly(user: User(name: "Kamol"))
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goToUserSubscribtionListModule() {
        
    }
    
    func goToSettingsMainListModule() {
        
    }
}
