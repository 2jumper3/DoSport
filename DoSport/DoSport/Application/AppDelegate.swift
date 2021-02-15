//
//  AppDelegate.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import UIKit
@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
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
