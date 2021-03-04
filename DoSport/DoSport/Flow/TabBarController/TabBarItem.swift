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
        // FIXME: we should not return VCs here because we creating them in coordinator afterwards
        switch self {
        case .home:
            return FeedAssembly().makeModule()
        case .map:
            return MapAssembly().makeModule()
        case .chat:
            return TypeSportsListController()
        case .user:
            return UserMainAssembly(user: nil).makeModule()
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
