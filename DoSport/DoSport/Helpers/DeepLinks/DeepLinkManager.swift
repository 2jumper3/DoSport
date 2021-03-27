//
//  DeepLinkManager.swift
//  DoSport
//
//  Created by Maxim Safronov on 20.03.2021.
//

import Foundation

enum DeepLink {
    enum Destination {
        case EventModule
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
    
    init() {
        print("DeepLinkManager was inited")
    }
    
    deinit {
        print("DeepLinkManager was deinited")
    }
    
    func handleURL(url: URL, appCoordinator: AppCoordinator?) {
        guard url.pathComponents.count >= 3 else { return }
        
        switch url.host {
        case "feed":
            guard let eventID = url.pathComponents.last else { return }
            let chat = Chat(ID: Int(eventID), messages: [], userID: nil, userName: nil)
            let event = Event(eventID: Int(eventID), eventDate: nil, eventEndTime: nil, eventStartTime: nil, organiserID: 1, chatID: chat, members: [], sportGroundID: 1, sportType: nil)
            addChildCoordinator(destination: .EventModule, coordinator: appCoordinator)
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
                    case .EventModule:
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
                                    if let mainTabBarCoordinator = coordinator as? MainTabBarCoordinator {
                                        mainTabBarCoordinator.childCoordinators.forEach { (coordinator) in
                                            switch destination {
                                            case .EventModule:
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
