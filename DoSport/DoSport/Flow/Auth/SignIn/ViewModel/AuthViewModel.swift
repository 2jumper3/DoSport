//
//  AuthViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import Foundation
import GoogleSignIn
import FBSDKLoginKit

enum SocialMediaType {
    case google, vkontakte, facebook, apple
}

protocol AuthViewModelProtocol: class {
    var onDidSignUpWithSocialMedia: ((AuthViewModel.ViewState) -> Swift.Void)? { get set }
    var onDidSendSignUpDataToServer: ((AuthViewModel.ViewState) -> Swift.Void)? { get set }
    
    func doSignUpWithSocialMedia(_ type: SocialMediaType, viewController: AuthViewController?)
    func doSendSignUpDataToServer()
}

final class AuthViewModel: NSObject, AuthViewModelProtocol {
    
    enum ViewState {
        case loading
        case failed
        case success
    }
    
    var onDidSignUpWithSocialMedia: ((AuthViewModel.ViewState) -> Swift.Void)?
    var onDidSendSignUpDataToServer: ((AuthViewModel.ViewState) -> Swift.Void)?
    
    private let requestsManager: RequestsManager
    
    init(requestsManager: RequestsManager) {
        self.requestsManager = requestsManager
        super.init()
        
    }

    func doSignUpWithSocialMedia(_ type: SocialMediaType, viewController: AuthViewController?) {
        onDidSignUpWithSocialMedia?( .loading)
        
        switch type {
        case .google:
            GIDSignIn.sharedInstance()?.presentingViewController = viewController
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            
            self.signUpWithGoogle()
            
        case .vkontakte:
            break
            
        case .facebook:
            self.signUpWithFacebook(from: viewController)
            
        case .apple:
            break
        }
    }
    
    func doSendSignUpDataToServer() {
        
    }
}

//MARK: Private API

private extension AuthViewModel {
    
    func signUpWithGoogle () {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func signUpWithFacebook(from viewController: AuthViewController?) {
        let fbLoginManager = LoginManager()
        
        fbLoginManager.logIn(permissions: [], from: viewController) { [unowned self] result, error in
            
            if error != nil {
                /// login error occured
                self.onDidSignUpWithSocialMedia?(.failed)
            } else if ((result?.isCancelled) != nil) {
                /// login cancelled
                self.onDidSignUpWithSocialMedia?(.failed)
            } else {
                /// login successfully
                self.onDidSignUpWithSocialMedia?(.success)
            }
        }
    }
}

//MARK: - Google SignUp Delegate -

extension AuthViewModel: GIDSignInDelegate {
    
    func sign(
        _ signIn: GIDSignIn!,
        didSignInFor user: GIDGoogleUser!,
        withError error: Error!
    ) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        let _ = user.userID
        let _ = user.authentication.idToken
        let _ = user.profile.name
        let _ = user.profile.givenName
        let _ = user.profile.familyName
        let _ = user.profile.email
//        print (userId,idToken,email)
    }
}

//MARK: - Facebook SignUp Delegate -

extension AuthViewModel: LoginButtonDelegate {
    
    func loginButton(
        _ loginButton: FBLoginButton,
        didCompleteWith result: LoginManagerLoginResult?,
        error: Error?
    ) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
}

