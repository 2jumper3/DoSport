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
    var deepLinkManager = DeepLinkManager()
    
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
        deepLinkManager.handleURL(url, self.appCoordinator)
        return true
    }
}
