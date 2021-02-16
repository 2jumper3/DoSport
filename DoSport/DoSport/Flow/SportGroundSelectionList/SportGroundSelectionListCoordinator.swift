//
//  SportGroundSelectionListCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 15/02/2021.
//

import UIKit

final class SportGroundSelectionListCoordinator: Coordinator {
    
    let rootViewController: SportGroundSelectionListViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    private let cell: UITableViewCell
    private let sportTypeTitle: String
    
    init(navController: UINavigationController?, cell: UITableViewCell, sportTypeTitle: String) {
        let assembly = SportGroundSelectionListAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
        self.cell = cell
        self.sportTypeTitle = sportTypeTitle
    }
    
    func start() {
        rootViewController.coordinator = self
        rootViewController.cell = cell
        rootViewController.sportTypeTitle = sportTypeTitle
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

