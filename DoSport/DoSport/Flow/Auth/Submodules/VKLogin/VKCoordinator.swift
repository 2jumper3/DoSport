//
//  VKCoordinator.swift
//  DoSport
//
//  Created by Sergey on 12.03.2021.
//

import UIKit

final class VKCoordinator: Coordinator {
    
    let rootViewController: WKWebViewController
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    
    init(navController: UINavigationController?) {
        let assembly = AuthAssembly()
        self.rootViewController = assembly.makeModule()
        self.navigationController = navController
    }
}
