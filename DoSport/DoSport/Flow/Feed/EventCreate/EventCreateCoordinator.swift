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
    
    func goToSportTypeListModule(completion: @escaping (String) -> Void) {
        let coordinator = SportTypeListCoordinator(
            navController: eventCreateNavController,
            completion: completion
        )
        
        self.store(coordinator: coordinator)
        coordinator.start()
    }
    
    func goToSportGroundSelectionListModule(sportTypeTitle: String, completion: @escaping (SportGround) -> Void) {
        let coordinator = SportGroundSelectionListCoordinator(
            navController: eventCreateNavController,
            sportTypeTitle: sportTypeTitle, 
            completion: completion
        )
        
        self.store(coordinator: coordinator)
        coordinator.start()
    }
    
    func goToDateSelectionModule(sportGround: SportGround, completion: @escaping (String) -> Void) {
        let coordinator = DateSelectionCoordinator(
            navController: eventCreateNavController,
            sportGround: sportGround,
            completion: completion
        )
        
        self.store(coordinator: coordinator)
        coordinator.start()
    }
}
