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
        launchOptions: [UIApplication.LaunchOptionsKey : Any]?
    ) -> Bool {
        
        if #available(iOS 13, *) {
            let pushManager = DSPushNotificationManager(userID: "currently_logged_in_user_id") // TODO: finish UN setup
            pushManager.registerForPushNotifications()
            
            FirebaseApp.configure()
            /// call this when app gets permission from user to send notifications to enable FCM to start configuration.
//            Messaging.messaging().autoInitEnabled = true
            
            /// alternative way to receive and FCM register token.
//            NotificationCenter.default.addObserver(
//                self,
//                selector: #selector(handleReceiveMessagingFromFirebase),
//                name: NSNotification.Name.MessagingRegistrationTokenRefreshed,
//                object: nil
//            )
            
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            let appCoordinator = AppCoordinator(window: window!)
            self.appCoordinator = appCoordinator
            self.appCoordinator?.start()
            
            window!.makeKeyAndVisible()
        }
        return true
    }
    
    /// Handle when app enters background when user leaves app
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
        window?.endEditing(true)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        deepLinkManager.handleURL(url, self.appCoordinator)
        return true
    }
}
