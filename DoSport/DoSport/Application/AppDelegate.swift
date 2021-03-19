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
    var feedCoordinator: FeedCoordinator?
    
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
        handleURL(url)
        return true
    }
    
    func handleURL(_ url: URL) {
        guard url.pathComponents.count >= 2 else { return }
        
        let idFromUrl = url.pathComponents.last
        
        print("url: \(url.absoluteURL)")
        print("scheme: \(url.scheme ?? "")")
        print("host: \(url.host ?? "")")
        print("path: \(url.path)")
        print("components: \(url.pathComponents)")
        print("idFromUrl: \(idFromUrl ?? "")")
        
        switch url.host {
        case "feed":
            guard let id = idFromUrl else { return }
            let chat = Chat(ID: Int(id), messages: [], userID: nil, userName: nil)
            let event = Event(eventID: Int(id), eventDate: nil, eventEndTime: nil, eventStartTime: nil, organiserID: 1, chatID: chat, members: [], sportGroundID: 1, sportType: nil)
            addChildCoordinator(.FeedCoordinator)
            feedCoordinator?.goToEventModule(withSelected: event)
        default: break
        }
    }
    
    enum SelectCoordinator {
        case FeedCoordinator
    }
    
    func addChildCoordinator(_ selectedCoordinator: SelectCoordinator) {
        guard let appCoordinator = self.appCoordinator else { return }
        appCoordinator.childCoordinators.forEach { coordinator in
            if let mainTabBarCoordinator = coordinator as? MainTabBarCoordinator {
                mainTabBarCoordinator.childCoordinators.forEach { coordinator in
                    switch selectedCoordinator {
                    case .FeedCoordinator:
                        if let feedCoordinator = coordinator as? FeedCoordinator {
                            self.feedCoordinator = feedCoordinator
                        }
                    }
                }
            }
        }
    }
}
