//
//  SettingsCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit

final class SettingsCoordinator: Coordinator {
    
    let rootViewController: SettingsController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        self.rootViewController = SettingsController()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goToUserAccountModule(with title: String?) {
        
    }
    
    func goToNotificationSettingsModule(with title: String?) {
        
    }
    
    func goToPrivacySettingsModule(with title: String?) {
        
    }
    
    func goToLanguageListModule(with title: String?) {
        
    }
    
    func goToSupportSettingsModule(with title: String?) {
        
    }
}
