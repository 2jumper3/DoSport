//
//  UserSupportSettingsCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

final class UserSupportSettingsCoordinator: Coordinator {
    
    let rootViewController: UserSupportSettingsController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        self.rootViewController = UserSupportSettingsController()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goToProblemReportModule() {
        let coordinator = UserReportMessageCoordinator(navController: navigationController)
        store(coordinator: coordinator)
        coordinator.start()
    }
    
    func goToSupportRequestModule() {
        
    }
    
    func goToDataUsagePolicyModule() {
        
    }
    
    func goToAppUsagePolicyModule() {
        
    }
}
