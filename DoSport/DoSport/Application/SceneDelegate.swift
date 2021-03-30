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
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let appCoordinator = AppCoordinator(window: window!)
        self.appCoordinator = appCoordinator
        self.appCoordinator?.start()
        window?.makeKeyAndVisible()
    }
}
