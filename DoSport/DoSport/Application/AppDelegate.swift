//
//  AppDelegate.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import UIKit
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {

    //, GIDSignInDelegate {
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
//              print("The user has not signed in before or they have since signed out.")
//            } else {
//              print("\(error.localizedDescription)")
//            }
//            return
//          }
//          // Perform any operations on signed in user here.
//          let userId = user.userID                  // For client-side use only!
//          let idToken = user.authentication.idToken // Safe to send to the server
//          let fullName = user.profile.name
//          let givenName = user.profile.givenName
//          let familyName = user.profile.familyName
//          let email = user.profile.email
//    }
    
    
    var window : UIWindow?
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        GIDSignIn.sharedInstance().clientID = "984564573884-3pkir2a9kpe9g0rei6rmghm99miie9ll.apps.googleusercontent.com"

        return true
    }
    
    /// Handle when app enters background when user leaves app
    func applicationDidEnterBackground(_ application: UIApplication) {
        window?.endEditing(true)
    }
}
