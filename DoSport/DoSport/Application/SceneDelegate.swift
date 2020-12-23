////
////  SceneDelegate.swift
////  DoSport
////
////  Created by Sergey on 18.12.2020.
////
import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window : UIWindow?
    func scene(_ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            if let windowScene = scene as? UIWindowScene {
                self.window = UIWindow(windowScene: windowScene)
                let vc = OnBoardingViewController()
                self.window!.rootViewController = vc
                self.window!.makeKeyAndVisible()
                self.window!.backgroundColor = .red
            }
    }
}
