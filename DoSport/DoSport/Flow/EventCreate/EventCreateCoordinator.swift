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
    private var eventCreateNavController = DSNavigationController()
    
    init(navController: UINavigationController?) {
        let assembly = EventCreateAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
    
    func start() {
        rootViewController.coordinator = self
        eventCreateNavController.modalPresentationStyle = .fullScreen
        eventCreateNavController.setViewControllers([rootViewController], animated: true)
        navigationController?.present(eventCreateNavController, animated: true, completion: nil)
    }
    
    func goBack() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func goToSportTypeListModule(with cell: UITableViewCell) {
        let coordinator = SportTypeListCoordinator(navController: eventCreateNavController, cell: cell)
        coordinator.start()
    }
    
    func goToPlaygroundListModule(with cell: UITableViewCell, and sportTypeTitle: String) {
        let coordinator = SportGroundSelectionListCoordinator(
            navController: navigationController,
            cell: cell,
            sportTypeTitle: sportTypeTitle
        )
        coordinator.start()
    }
    
    func goToDateSelectionModule(with cell: UITableViewCell) {
        let coordinator = DateSelectionCoordinator(navController: eventCreateNavController, cell: cell)
        coordinator.start()
    }
}
