//
//  DSPushNotificationManager.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 13/03/2021.
//

import UserNotifications
import Firebase
//import FirebaseFirestore // TODO: Install FirebaseFirestore if needed
import FirebaseMessaging

final class DSPushNotificationManager: NSObject {
    
    private let userID: String
    
    init(userID: String) {
        self.userID = userID
        super.init()
    }
}

//MARK: Public API

extension DSPushNotificationManager {
    
    /// add desc
    func registerForPushNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
//        updateFirestorePushTokenIfNeeded()
    }
}

//MARK: - UNUserNotificationCenterDelegate -

extension DSPushNotificationManager: UNUserNotificationCenterDelegate {
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        completionHandler([.badge, .sound])
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        print(response)
        
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

extension DSPushNotificationManager: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: Messaging) {
        
    }
}
