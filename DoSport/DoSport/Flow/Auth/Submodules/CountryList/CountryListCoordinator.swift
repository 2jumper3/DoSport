//
//  CountryListCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/12/2020.
//

import UIKit

final class CountryListCoordinator: Coordinator {
    
    var rootViewController: CountryListViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = CountryListAssembly()
        self.navigationController = navController
        self.rootViewController = assembly.makeModule()
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
}
