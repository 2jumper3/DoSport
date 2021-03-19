//
//  DeepLinkManager.swift
//  DoSport
//
//  Created by Maxim Safronov on 20.03.2021.
//

import Foundation

enum SelectCoordinator {
    case FeedCoordinator
}

final class DeepLinkManager {
    static let shared = DeepLinkManager()
    
    var feedCoordinator: FeedCoordinator?
    
    func handleURL(_ url: URL, _ appCoordinator: AppCoordinator?) {
        guard url.pathComponents.count >= 2 else { return }
        
        let idFromUrl = url.pathComponents.last
        
        print("url: \(url.absoluteURL)")
        print("scheme: \(url.scheme ?? "")")
        print("host: \(url.host ?? "")")
        print("path: \(url.path)")
        print("components: \(url.pathComponents)")
        print("idFromUrl: \(idFromUrl ?? "")")
        
        switch url.host {
        case "feed":
            guard let id = idFromUrl else { return }
            let chat = Chat(ID: Int(id), messages: [], userID: nil, userName: nil)
            let event = Event(eventID: Int(id), eventDate: nil, eventEndTime: nil, eventStartTime: nil, organiserID: 1, chatID: chat, members: [], sportGroundID: 1, sportType: nil)
            addChildCoordinator(.FeedCoordinator, appCoordinator)
            feedCoordinator?.goToEventModule(withSelected: event)
        default: break
        }
    }
    
    func addChildCoordinator(_ selectedCoordinator: SelectCoordinator, _ appCoordinator: AppCoordinator?) {
        guard let appCoordinator = appCoordinator else { return }
        appCoordinator.childCoordinators.forEach { coordinator in
            if let mainTabBarCoordinator = coordinator as? MainTabBarCoordinator {
                mainTabBarCoordinator.childCoordinators.forEach { coordinator in
                    switch selectedCoordinator {
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
