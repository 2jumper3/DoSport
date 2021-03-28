//
//  UserAccountEditingCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit

final class UserAccountEditingCoordinator: Coordinator {
    
    let rootViewController: UserAccountEditingController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = UserAccountEditingAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goToSignInModule() {
        guard
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate
                as? SceneDelegate,
            let appCoodinator = sceneDelegate.appCoordinator
        else {
            return
        }
        print(appCoodinator.childCoordinators)
        let coordiator = SignInCoordinator(navController: navigationController)
        self.store(coordinator: coordiator)
        coordiator.startModally()
    }
}
