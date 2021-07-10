//
//  SportGroundMainCoordinator.swift
//  DoSport
//
//  Created by Sergey on 05.04.2021.
//


import UIKit

final class SportGroundMainCoordinator: Coordinator {
    
    let rootViewController: SportGroundMainController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(
        navController: UINavigationController?,
        sportTypeTitle: String
    ) {
        let assembly = SportGroundMainAssembly(
            sportTypeTitle: sportTypeTitle
        )
        
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
    func goToMap() {
        let coordinator = MapCoordinator(navController: navigationController)
        self.store(coordinator: coordinator)
        coordinator.start()
    }
    func goToSportGround(sportGround: DSModels.SportGround.SportGroundResponse) {
        let coordinator = SportGroundDetailCoordinator(navController: navigationController, sportGround: sportGround, contentType: .info)
        self.store(coordinator: coordinator)
        coordinator.start()
    }
    func goToEvent(event: DSModels.Event.EventView) {
        goBack()
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
