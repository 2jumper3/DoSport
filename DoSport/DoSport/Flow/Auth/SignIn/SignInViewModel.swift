//
//  SignInViewModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import Foundation
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

enum SocialMediaType {
    case google, vkontakte, facebook, apple
}

protocol SignInViewModelProtocol: class {
    var onDidSignUpWithSocialMedia: ((SignInViewModel.ViewState) -> Swift.Void)? { get set }
    var onDidSendSignUpDataToServer: ((SignInViewModel.ViewState) -> Swift.Void)? { get set }
    var onDidLogin: ((SignInViewModel.ViewState) -> Swift.Void)? { get set }
    
    func doSignUpWithSocialMedia(_ type: SocialMediaType, viewController: SingInViewController?)
    func doLogin(with data: DSModels.Auth.SignInRequest)
    func doSendSignUpDataToServer()
}

final class SignInViewModel: NSObject, SignInViewModelProtocol {
    
    enum ViewState {
        case loading
        case failed
        case success
    }
    
    var onDidSignUpWithSocialMedia: ((SignInViewModel.ViewState) -> Swift.Void)?
    var onDidSendSignUpDataToServer: ((SignInViewModel.ViewState) -> Swift.Void)?
    var onDidLogin: ((SignInViewModel.ViewState) -> Swift.Void)?
    
    private let userAccountService: UserAccountServiceProtocol
    private let userNetworkService: UserNetworkServiceProtocol
    private let authNetworkService: AuthNetworkServiceProtocol
    
    init(
        authNetworkService: AuthNetworkServiceProtocol,
        userNetworkService: UserNetworkServiceProtocol,
        userAccountService: UserAccountServiceProtocol
    ) {
        self.userNetworkService = userNetworkService
        self.userAccountService = userAccountService
        self.authNetworkService = authNetworkService
        super.init()
    }
    
    func doLogin(with data:  DSModels.Auth.SignInRequest) {
        self.onDidLogin?(.loading)
        
        self.authNetworkService.authSignIn(bodyObject: data) { [unowned self] response in
            
            switch response {
            case .success(let responseData):
                self.doLoadUser(using: responseData.token) { [unowned self] user in
                    self.userAccountService.currentUser = user
                    
                    self.onDidLogin?(.success)
                }
                
            case .failure:
                self.onDidLogin?(.failed)
            }
        }
    }
    
    private func doLoadUser(
        using token: String?,
        completion: @escaping (DSModels.User.UserView) -> Swift.Void
    ) {
        if let jwtToken = token {
            self.userAccountService.jwtToken = jwtToken
        }
        
        self.userNetworkService.userProfileGet { response in
            switch response {
            case .success(let responseData):
                completion(responseData)
                
            case .failure:
                self.onDidLogin?(.failed)
            }
        }
    }
    
    func doSignUpWithSocialMedia(_ type: SocialMediaType, viewController: SingInViewController?) {
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

private extension SignInViewModel {
    
    func signUpWithGoogle () {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func signUpWithFacebook(from viewController: SingInViewController?) {
        let fbLoginManager = LoginManager()
        if let currentAccessToken = AccessToken.current, currentAccessToken.appID != Settings.appID
            {
            fbLoginManager.logOut()
            }
        fbLoginManager.logIn(permissions: ["public_profile","email","id"], from: viewController) { [unowned self] result, error in
            
            if error != nil {
                /// login error occured
                self.onDidSignUpWithSocialMedia?(.failed)
                print(error)
                print("Login failed")
            } else if ((result?.isCancelled) != nil) {
                /// login cancelled Bug on facebook
                self.onDidSignUpWithSocialMedia?(.failed)
                
                let connection  = GraphRequestConnection()
                connection.add(GraphRequest(graphPath: "/me", parameters: ["fields" : "id,first_name,last_name,email,name"], tokenString: AccessToken.current?.tokenString, version: Settings.defaultGraphAPIVersion, httpMethod: .get)) { (connection, values, error) in
                       if let res = values {
                            if let response = res as? [String:Any] {
                                let id: [String: Any] = ["id": response["id"]]
                                let email: [String: Any] = ["email": response["email"]]
                                print(id,email)
                            }
                       }
                }
                connection.start()
                print("Logic cancelled")
                
            } else {
                /// login successfully
                self.onDidSignUpWithSocialMedia?(.success)
                print("Login success")
            }
        }
    }
}

//MARK: - Google SignUp Delegate -

extension SignInViewModel: GIDSignInDelegate {
    
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
        
        NotificationCenter.default.post(
            name: Notification.Name(Notifications.googleSignSuccess), object: nil, userInfo: nil)
        
        let userId = user.userID
        let _ = user.authentication.idToken
        let _ = user.profile.name
        let _ = user.profile.givenName
        let _ = user.profile.familyName
        let email = user.profile.email
        print (userId,email)
    }
}

//MARK: - Facebook SignUp Delegate -

extension SignInViewModel: LoginButtonDelegate {
    
    func loginButton(
        _ loginButton: FBLoginButton,
        didCompleteWith result: LoginManagerLoginResult?,
        error: Error?
    ) {
        print("Login button tapped")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
}

