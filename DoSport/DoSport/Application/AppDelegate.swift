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
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        YMKMapKit.setApiKey("5607e97e-f6e8-4965-a467-a2335061e946")

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
