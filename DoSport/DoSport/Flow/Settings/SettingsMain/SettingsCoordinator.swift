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
    
    func goToUserAccountEditingModule() {
        let coordinator = UserAccountEditingCoordinator(navController: navigationController)
        coordinator.start()
    }
    
    func goToNotificationSettingsModule(with title: String?) {
        let coordinator = NotificationSettingsCoordinator(navController: navigationController)
        coordinator.start()
    }
    
    func goToPrivacySettingsModule(compilation: @escaping (PrivacySettingType) -> Swift.Void) {
        let coordinator = PrivacySettingListCoordinator(
            navController: navigationController,
            compilation: compilation
        )
        
        coordinator.start()
    }
    
    func goToLanguageListModule(compilation: @escaping (AppLanguageModel.Language) -> Swift.Void) {
        let coordinator = AppLanguageListCoordinator(
            navController: navigationController,
            compilation: compilation
        )
        
        coordinator.start()
    }
    
    func goToSupportSettingsModule(with title: String?) {
        let coordinator = UserSupportSettingsCoordinator(navController: navigationController)
        
        coordinator.start()
    }
}
