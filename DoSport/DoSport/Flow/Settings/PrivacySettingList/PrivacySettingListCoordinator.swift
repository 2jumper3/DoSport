//
//  PrivacySettingListCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

final class PrivacySettingListCoordinator: Coordinator {
    
    let rootViewController: PrivacySettingListController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?, compilation: @escaping (PrivacySettingType) -> Swift.Void) {
        self.rootViewController = PrivacySettingListController(compilation: compilation)
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
}
