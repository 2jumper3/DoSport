//
//  SportTypeListCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class SportTypeListCoordinator: Coordinator {
    
    let rootViewController: SportTypeListViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    private let cell: UITableViewCell
    
    init(navController: UINavigationController?, cell: UITableViewCell) {
        let assembly = SportTypeListAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
        self.cell = cell
    }
    
    func start() {
        rootViewController.coordinator = self
        rootViewController.cell = cell
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
