//
//  TabBarItem.swift
//  DoSport
//
//  Created by Sergey on 24.12.2020.
//
import UIKit

// Enum for naming icons
enum TabBarItem: String, CaseIterable {

    case home = "Home"
    case map = "Map"
    case chat = "Chat"
    case user = "User"
    
//Need to add newControllers when it will be finished
    var viewController: UIViewController {
        switch self {
        case .home:
            let navigationController = DSNavigationController()
            let coordinator = FeedCoordinator(navController: navigationController)
            coordinator.start()
            
            guard let navController = coordinator.navigationController else { return UIViewController() }
            
            return navController
        case .map:
            return MainViewController()
        case .chat:
            return MainViewController()
        case .user:
            return MainViewController()
        }
    }

    var icon: UIImage {
        switch self {
        case .home:
            return UIImage(named: "homeInactive") ?? UIImage()
        case .map:
            return UIImage(named: "mapInactive") ?? UIImage()
        case .chat:
            return UIImage(named: "chatInactive") ?? UIImage()
        case .user:
            return UIImage(named: "userInactive") ?? UIImage()
        }
    }

    var displayTitle: String {
        return self.rawValue
    }
}
