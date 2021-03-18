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
    var viewModel: FeedViewModel?
    
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
            let temp = appCoordinator.childCoordinators.forEach { (coordinator) in
                if let mainTabBarCoordinator = coordinator as? MainTabBarCoordinator {
                    mainTabBarCoordinator.childCoordinators.forEach { (coordinator2) in
                        if let feedCoordinator = coordinator2 as? FeedCoordinator {
                            print("Match")
                            self.feedCoordinator = feedCoordinator
                        }
                    }
                }
            }
            window!.makeKeyAndVisible()
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            
            
            print("url: \(url.absoluteURL)")
            print("scheme: \(url.scheme)")
            print("host: \(url.host)")
            print("path: \(url.path)")
            print("components: \(url.pathComponents)")
            
            let urlString = url.absoluteString
            
            guard let stringId = urlString.split(separator: "=").last, let id = Int(stringId) else { return }
            
            print("eventID: \(id)")
            
            let chat = Chat(ID: 1, messages: [], userID: nil, userName: nil)
            
            let event = Event(eventID: id, eventDate: nil, eventEndTime: nil, eventStartTime: nil, organiserID: 1, chatID: chat, members: [], sportGroundID: 1, sportType: nil)
            
            
            feedCoordinator?.goToEventModule(withSelected: event)
        }
    }
}
