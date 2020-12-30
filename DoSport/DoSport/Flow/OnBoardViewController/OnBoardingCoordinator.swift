//
//  OnBoardingCoordinator.swift
//  DoSport
//
//  Created by Sergey on 28.12.2020.
//

import UIKit

final class OnBoardingCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var childCoordinators = [Coordinator]()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = OnBoardingViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
}
