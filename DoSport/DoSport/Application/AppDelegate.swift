//
//  AppDelegate.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        if #available(iOS 13, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (_, _) in }
            Messaging.messaging().delegate = self
            
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
    
    /// Tells the delegate that the app successfully registered with Apple Push Notification service
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    /// Handle when app enters background when user leaves app
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
        window?.endEditing(true)
    }
}

@objc private extension AppDelegate {
    
    /// Called when Firebase registration token is received
    @objc func handleReceiveMessagingFromFirebase() {
        
    }
}

//MARK: - UNUserNotificationCenterDelegate -

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        completionHandler([[.alert, .sound]])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        completionHandler()
    }
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        print(userInfo)
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler(.noData)
    }
}

//MARK: - Firebase | MessagingDelegate -

extension AppDelegate: MessagingDelegate {

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
    }
}
