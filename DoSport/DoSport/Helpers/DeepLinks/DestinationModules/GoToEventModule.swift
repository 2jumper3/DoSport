//
//  GoToEventModule.swift
//  DoSport
//
//  Created by Maxim Safronov on 25.03.2021.
//

import Foundation

class GoToEventModule: DeepLinkDestinationModule {
    
    var feedCoordinator: FeedCoordinator?
    
    func getDestination(components: DeepLinkComponents) {
        if components.url.host == "feed" {
            guard let eventIDString = components.url.pathComponents.last,
                  let eventID = Int(eventIDString),
                  let appCoordinator = components.coordinator else
            {
                return
            }
            
            let chat = Chat(ID: eventID, messages: [], userID: nil, userName: nil)
            let event = Event(eventID: eventID, eventDate: nil, eventEndTime: nil, eventStartTime: nil, organiserID: 1, chatID: chat, members: [], sportGroundID: 1, sportType: nil)
            
            appCoordinator.childCoordinators.forEach { coordinator in
                if let mainTabBarCoordinator = coordinator as? MainTabBarCoordinator {
                    mainTabBarCoordinator.childCoordinators.forEach { coordinator in
                        if let feedCoordinator = coordinator as? FeedCoordinator {
                            self.feedCoordinator = feedCoordinator
                            self.feedCoordinator?.goToEventModule(withSelected: event)
                        }
                        
                    }
                }
                // Это временная реализация, потому как пользователь неавторизован
                if let onBoardingCoordinator = coordinator as? OnBoardingCoordinator {
                    onBoardingCoordinator.childCoordinators.forEach { coordinator in
                        if let authCoordinator = coordinator as? AuthCoordinator {
                            authCoordinator.childCoordinators.forEach { coordinator in
                                if let registrationCoordinator = coordinator as? RegistrationCoordinator {
                                    registrationCoordinator.childCoordinators.forEach { coordinator in
                                        if let mainTabBarCoordinator = coordinator as? MainTabBarCoordinator {
                                            mainTabBarCoordinator.childCoordinators.forEach { coordinator in
                                                if let feedCoordinator = coordinator as? FeedCoordinator {
                                                    self.feedCoordinator = feedCoordinator
                                                    self.feedCoordinator?.goToEventModule(withSelected: event)
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
