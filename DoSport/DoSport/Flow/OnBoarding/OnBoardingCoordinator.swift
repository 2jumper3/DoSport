//
//  OnBoardingCoordinator.swift
//  DoSport
//
//  Created by Sergey on 17.01.2021.
//

import UIKit

final class OnBoardingCoordinator: Coordinator {
    
    private var rootViewController: OnBoardingViewController?
    
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        self.navigationController = navController
//        self.navigationController?.navigationBar.barTintColor = Colors.darkBlue
//        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func start() {
        let viewModel: OnBoardingViewModelProtocol = OnBoardingViewModel(coordinator: self)
        self.rootViewController = OnBoardingViewController(viewModel: viewModel)
        
        if let _ = self.rootViewController {
            self.navigationController?.setViewControllers([rootViewController!], animated: true)
        }
    }
    
    func goToAuthView() {
        let coordiator = SignInCoordinator(navController: navigationController)
        coordiator.start()
    }
}
