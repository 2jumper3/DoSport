//
//  EventCreateCoordinator.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 08/02/2021.
//

import UIKit

final class EventCreateCoordinator: Coordinator {
    
    let rootViewController: EventCreateViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = EventCreateAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        navigationController?.pushViewController(rootViewController, animated: true)
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func goToSportTypeListModule(with cell: UITableViewCell) {
        let coordinator = SportTypeListCoordinator(navController: self.navigationController, cell: cell)
        coordinator.start()
    }
    
    func goToPlaygroundListModule(with cell: UITableViewCell) {
        print(#function)
    }
    
    func goToDateSelectionModule(with cell: UITableViewCell) {
        let coordinator = DateSelectionCoordinator(navController: self.navigationController, cell: cell)
        coordinator.start()
    }
}
