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
    
    var viewController: String {
        switch self {
        case .home: return self.rawValue
        case .map: return self.rawValue
        case .chat: return self.rawValue
        case .user: return self.rawValue
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
