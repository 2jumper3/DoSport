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
    var onSigningUpWithSocialMedia: ((SignInViewModel.ViewState) -> Swift.Void)? { get set }
    var onSendingSignUpDataToServer: ((SignInViewModel.ViewState) -> Swift.Void)? { get set }
    var onLogining: ((SignInViewModel.ViewState) -> Swift.Void)? { get set }
    
    func doSignUpWithSocialMedia(_ type: SocialMediaType, viewController: SingInViewController?)
    func doLogin(with data: DSModels.Auth.SignInRequest)
    func doSendSignUpDataToServer()
    
    func goToSignUpModuleRequest()
    func goToFeedModuleRequest()
    func openVKAuthViewRequest()
}

final class SignInViewModel: NSObject, SignInViewModelProtocol {
    
    enum ViewState {
        case loading
        case failed
        case success
    }
    
    var onSigningUpWithSocialMedia: ((SignInViewModel.ViewState) -> Swift.Void)?
    var onSendingSignUpDataToServer: ((SignInViewModel.ViewState) -> Swift.Void)?
    var onLogining: ((SignInViewModel.ViewState) -> Swift.Void)?
    
    private weak var coordinator: SignInCoordinator?
    private let userAccountService: UserAccountServiceProtocol
    private let userNetworkService: UserNetworkServiceProtocol
    private let authNetworkService: AuthNetworkServiceProtocol
    
    init(
        coordinator: SignInCoordinator,
        authNetworkService: AuthNetworkServiceProtocol,
        userNetworkService: UserNetworkServiceProtocol,
        userAccountService: UserAccountServiceProtocol
    ) {
        self.userNetworkService = userNetworkService
        self.userAccountService = userAccountService
        self.authNetworkService = authNetworkService
        self.coordinator = coordinator
        super.init()
    }
    
    func doLogin(with data:  DSModels.Auth.SignInRequest) {
        self.onLogining?(.loading)
        
        self.authNetworkService.authSignIn(bodyObject: data) { [unowned self] response in
            
            switch response {
            case .success(let responseData):
                self.doLoadUser(using: responseData.token) { [unowned self] user in
                    self.userAccountService.currentUser = user
                    
                    self.onLogining?(.success)
                }
                
            case .failure:
                self.onLogining?(.failed)
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
        
        self.userNetworkService.userProfileGet { [unowned self] response in
            switch response {
            case .success(let responseData):
                completion(responseData)
                
            case .failure:
                self.onLogining?(.failed)
            }
        }
    }
    
    func doSignUpWithSocialMedia(_ type: SocialMediaType, viewController: SingInViewController?) {
        onSigningUpWithSocialMedia?( .loading)
        
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
    
    func goToSignUpModuleRequest() {
        self.coordinator?.goToRegistrationModule()
    }
    
    func goToFeedModuleRequest() {
        self.coordinator?.goToFeedModule()
    }
    
    func openVKAuthViewRequest() {
        self.coordinator?.openVkAuthView()
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
                self.onSigningUpWithSocialMedia?(.failed)
            } else if ((result?.isCancelled) != nil) {
                /// login cancelled
                self.onSigningUpWithSocialMedia?(.failed)
            } else {
                /// login successfully
                self.onSigningUpWithSocialMedia?(.success)
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

