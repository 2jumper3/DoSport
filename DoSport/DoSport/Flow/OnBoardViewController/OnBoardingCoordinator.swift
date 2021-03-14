//
//  OnBoardingCoordinator.swift
//  DoSport
//
//  Created by Sergey on 17.01.2021.
//

import UIKit

final class OnBoardingCoordinator: Coordinator {
    
    let rootViewController: OnBoardingViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = OnBoardingAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
        self.navigationController?.navigationBar.barTintColor = Colors.darkBlue
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
    
    func goToAuthView() {
        if #available(iOS 13.0, *) {
            let coordiator = AuthCoordinator(navController: navigationController)
            store(coordinator: coordiator)
            coordiator.start()
        }
    }
}
