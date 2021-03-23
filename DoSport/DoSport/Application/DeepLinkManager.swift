//
//  DeepLinkManager.swift
//  DoSport
//
//  Created by Maxim Safronov on 20.03.2021.
//

import Foundation

enum DeepLink {
    enum Destination {
        case FeedCoordinator
    }
    
    enum Url {
        static let event = "dosport://feed/event/"
    }
}

protocol DeepLinkManagerProtocol: class {
    func handleURL(url: URL, appCoordinator: AppCoordinator?)
}

final class DeepLinkManager: DeepLinkManagerProtocol {
    var feedCoordinator: FeedCoordinator?
    
    func handleURL(url: URL, appCoordinator: AppCoordinator?) {
        guard url.pathComponents.count >= 3 else { return }
        
        let idFromUrl = url.pathComponents.last
        
        switch url.host {
        case "feed":
            guard let id = idFromUrl else { return }
            let chat = Chat(ID: Int(id), messages: [], userID: nil, userName: nil)
            let event = Event(eventID: Int(id), eventDate: nil, eventEndTime: nil, eventStartTime: nil, organiserID: 1, chatID: chat, members: [], sportGroundID: 1, sportType: nil)
            addChildCoordinator(destination: .FeedCoordinator, coordinator: appCoordinator)
            feedCoordinator?.goToEventModule(withSelected: event)
        default: break
        }
    }
    
    func addChildCoordinator(destination: DeepLink.Destination, coordinator: AppCoordinator?) {
        guard let appCoordinator = coordinator else { return }
        appCoordinator.childCoordinators.forEach { coordinator in
            if let mainTabBarCoordinator = coordinator as? MainTabBarCoordinator {
                mainTabBarCoordinator.childCoordinators.forEach { coordinator in
                    switch destination {
                    case .FeedCoordinator:
                        if let feedCoordinator = coordinator as? FeedCoordinator {
                            self.feedCoordinator = feedCoordinator
                        }
                    }
                }
            }
            // Это временная реализация, потому как пользователь неавторизован
            if let onBoardingCoordinator = coordinator as? OnBoardingCoordinator {
                onBoardingCoordinator.childCoordinators.forEach { coordinator in
                    if let authCoordinator = coordinator as? AuthCoordinator {
                        authCoordinator.childCoordinators.forEach { (coordinator) in
                            if let registrationCoordinator = coordinator as? RegistrationCoordinator {
                                registrationCoordinator.childCoordinators.forEach { (coordinator) in
                                    if let sportTypeGridCoordinator = coordinator as? SportTypeGridCoordinator {
                                        sportTypeGridCoordinator.childCoordinators.forEach { (coordinator) in
                                            if let mainTabBarCoordinator = coordinator as? MainTabBarCoordinator {
                                                mainTabBarCoordinator.childCoordinators.forEach { (coordinator) in
                                                    switch destination {
                                                    case .FeedCoordinator:
                                                        if let feedCoordinator = coordinator as? FeedCoordinator {
                                                            self.feedCoordinator = feedCoordinator
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
