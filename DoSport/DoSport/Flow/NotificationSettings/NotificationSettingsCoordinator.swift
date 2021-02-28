//
//  NotificationSettingsCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

final class NotificationSettingsCoordinator: Coordinator {
    
    let rootViewController: NotificationSettingsController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        self.rootViewController = NotificationSettingsController()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goToUserAccountEditingModule() {
        
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
