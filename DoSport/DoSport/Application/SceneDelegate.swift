//
//  SceneDelegate.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    weak var deepLinkServiceProtocol: DeepLinkServiceProtocol?
    
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
        guard let urlToOpen = URLContexts.first?.url,
              let appCoordinator = self.appCoordinator else { return }
        
        let components = DeepLinkComponents(url: urlToOpen, coordinator: appCoordinator)
        let goToEventModule = GoToEventModule()
        let deepLinkService = DeepLinkService(destinations: [goToEventModule])
        self.deepLinkServiceProtocol = deepLinkService
        self.deepLinkServiceProtocol?.handleURL(with: components)
    }
}
