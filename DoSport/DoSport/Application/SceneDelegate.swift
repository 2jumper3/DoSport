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
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            //                let vc = ViewController()
            
            let appCoordinator = AppCoordinator(window: window!)
            self.appCoordinator = appCoordinator
            self.appCoordinator?.start()
            
            window!.makeKeyAndVisible()
        }
    }
}
