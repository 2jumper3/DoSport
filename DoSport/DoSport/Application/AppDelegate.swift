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
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
            if #available(iOS 13, *) {
                // do only pure app launch stuff, not interface stuff
            } else {
                self.window = UIWindow()
                let vc = OnBoardingViewController()
                self.window!.rootViewController = vc
                self.window!.makeKeyAndVisible()
                self.window!.backgroundColor = .red
            }
            return true
    }
}
