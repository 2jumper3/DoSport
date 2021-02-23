//
//  AppDelegate.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import UIKit
import YandexMapsMobile
@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        YMKMapKit.setApiKey("5607e97e-f6e8-4965-a467-a2335061e946")

            if #available(iOS 13, *) {
                // do only pure app launch stuff, not interface stuff
            } else {
                window = UIWindow(frame: UIScreen.main.bounds)
                let appCoordinator = AppCoordinator(window: window!)
                self.appCoordinator = appCoordinator
                self.appCoordinator?.start()

                window!.makeKeyAndVisible()
            }
            return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
        window?.endEditing(true)
    }
}
