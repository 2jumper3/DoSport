//
//  AppDelegate.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    var appCoordinator: AppCoordinator?
    weak var deeplink: DeepLinkManagerProtocol?
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let pushManager = DSPushNotificationManager(userID: "currently_logged_in_user_id") // TODO: finish UN setup
        pushManager.registerForPushNotifications()
        
        FirebaseApp.configure()
        return true
    }
    
    /// Handle when app enters background when user leaves app
    func applicationDidEnterBackground(_ application: UIApplication) {
        window?.endEditing(true)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let deeplink = DeepLinkManager()
        self.deeplink = deeplink
        self.deeplink?.handleURL(url: url, appCoordinator: self.appCoordinator)
        return true
    }
}
