//
//  AuthManager.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/03/2021.
//

import AuthenticationServices
import UIKit.UIViewController

@available(iOS 13.0, *)
protocol AuthManagerProtocol: class {
    func signInWithApple(for viewController: UIViewController)
    func signInWithGoogle()
    func signInWithFacebook()
}

public final class AuthManager: NSObject {
    
    private weak var viewContorller: UIViewController?
    
    //MARK: Init
    
    public override init() {
        super.init()
    }
}

//MARK: - AuthManagerProtocol -

@available(iOS 13.0, *)
extension AuthManager: AuthManagerProtocol {
    
    func signInWithApple(for viewController: UIViewController) {
        self.viewContorller = viewController
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func signInWithGoogle() {
        
    }
    
    func signInWithFacebook() {
        
    }
}

//MARK: - SignIn With Apple -

@available(iOS 13.0, *)
extension AuthManager: ASAuthorizationControllerDelegate {
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        
    }
}

@available(iOS 13.0, *)
extension AuthManager: ASAuthorizationControllerPresentationContextProviding {
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = self.viewContorller?.view.window else {
            return ASPresentationAnchor()
        }
        
        return window
    }
}

//MARK: - Sign In With FaceBook -

//MARK: - Sign In With Google -
