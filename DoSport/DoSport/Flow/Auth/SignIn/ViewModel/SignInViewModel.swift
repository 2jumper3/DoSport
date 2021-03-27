//
//  SignInViewModel.swift
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

protocol SignInViewModelProtocol: class {
    var onDidSignUpWithSocialMedia: ((SignInViewModel.ViewState) -> Swift.Void)? { get set }
    var onDidSendSignUpDataToServer: ((SignInViewModel.ViewState) -> Swift.Void)? { get set }
    var onDidLogin: ((SignInViewModel.ViewState) -> Swift.Void)? { get set }
    
    func doSignUpWithSocialMedia(_ type: SocialMediaType, viewController: SingInViewController?)
    func doLogin(with data: DSModels.Auth.SignInRequest)
    func doSendSignUpDataToServer()
}

final class SignInViewModel: NSObject, SignInViewModelProtocol {
    
    typealias Dependencies = SignInServices
    
    enum ViewState {
        case loading
        case failed
        case success
    }
    
    var onDidSignUpWithSocialMedia: ((SignInViewModel.ViewState) -> Swift.Void)?
    var onDidSendSignUpDataToServer: ((SignInViewModel.ViewState) -> Swift.Void)?
    var onDidLogin: ((SignInViewModel.ViewState) -> Swift.Void)?
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
    }
    
    func doLogin(with data:  DSModels.Auth.SignInRequest) {
        self.onDidLogin?(.loading)
        
        self.dependencies.authNetworkService.authSignIn(bodyObject: data) { [unowned self] response in
            
            switch response {
            case .success(let responseData):
                self.doLoadUser(using: responseData.token) { [unowned self] user in
                    self.dependencies.userAccountService.currentUser = user
                    
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
            dependencies.userAccountService.jwtToken = jwtToken
        }
        
        self.dependencies.userNetworkService.userProfileGet { response in
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
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func signUpWithFacebook(from viewController: SingInViewController?) {
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

extension SignInViewModel: LoginButtonDelegate {
    
    func loginButton(
        _ loginButton: FBLoginButton,
        didCompleteWith result: LoginManagerLoginResult?,
        error: Error?
    ) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
}

