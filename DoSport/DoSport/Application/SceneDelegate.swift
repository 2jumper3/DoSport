////
////  SceneDelegate.swift
////  DoSport
////
////  Created by Sergey on 18.12.2020.
////
import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var feedCoordinator: FeedCoordinator?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        //        if let windowScene = scene as? UIWindowScene {
        //                        self.window = UIWindow(windowScene: windowScene)
        //                        let vc = MainMenuTabController()
        //                        self.window!.rootViewController = vc
        //                        self.window!.makeKeyAndVisible()
        //                        self.window!.backgroundColor = .red
        //                    }
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            let appCoordinator = AppCoordinator(window: window!)
            self.appCoordinator = appCoordinator
            self.appCoordinator?.start()
            window!.makeKeyAndVisible()
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let urlToOpen = URLContexts.first?.url else { return }
        handleURL(urlToOpen)
    }
    
    func handleURL(_ url: URL) {
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
            addChildCoordinator(.FeedCoordinator)
            feedCoordinator?.goToEventModule(withSelected: event)
        default: break
        }
    }
    
    enum SelectCoordinator {
        case FeedCoordinator
    }
    
    func addChildCoordinator(_ selectedCoordinator: SelectCoordinator) {
        guard let appCoordinator = self.appCoordinator else { return }
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
