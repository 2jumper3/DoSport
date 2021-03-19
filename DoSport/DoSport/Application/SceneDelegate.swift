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
    var deepLinkManager = DeepLinkManager()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
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
        deepLinkManager.handleURL(urlToOpen, self.appCoordinator)
    }
}
