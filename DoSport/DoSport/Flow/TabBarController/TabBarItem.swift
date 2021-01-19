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

    var viewController: UIViewController {
        switch self {
        case .home:
            return DSNavigationController(rootViewController: TypeSportsListController())
        case .map:
            return TypeSportsListController()
        case .list:
            return TypeSportsListController()
        case .chat:
            return TypeSportsListController()
        case .user:
            return TypeSportsListController()
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
