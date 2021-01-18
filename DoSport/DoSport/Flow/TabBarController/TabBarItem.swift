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
    case list = "Main"
    case chat = "Chat"
    case user = "User"
//Need to add newControllers when it will be finished
    var viewController: UIViewController {
        switch self {
        case .home:
            return UINavigationController(rootViewController: MainViewController())
        case .map:
            let assembly = MapAssembly()
            let viewController = assembly.makeModule()
            return viewController
        case .list:
            return MainViewController()
        case .chat:
            return MainViewController()
        case .user:
            return MainViewController()
        }
    }

    var icon: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "homeInactive")!
        case .map:
            return UIImage(named: "mapInactive")!
        case .list:
            return UIImage(named: "listInative")!
        case .chat:
            return UIImage(named: "chatInactive")!
        case .user:
            return UIImage(named: "userInactive")!
        }
    }

    var displayTitle: String {
        return self.rawValue
    }
}
