//
//  AuthViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

final class AuthViewController: UIViewController {
    
    weak var coordinator: AuthCoordinator?
    private let viewModel: AuthViewModel
    
    private lazy var authView = self.view as! AuthView
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = AuthView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Google methods
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
    
}

//MARK: - AuthViewDelegate -

extension AuthViewController: AuthViewDelegate {
    func submitButtonTapped(with text: String) {
        
    }
    
    func regionSelectionButtonTapped() {
        
    }
    
    
    func vkAuthButtonClicked() {
        coordinator?.openVkAuthView(completion: {
            self.coordinator?.dismissWKWebView()
            self.coordinator?.goToMainTabBar()
        })
        
    }
    
    func fbAuthClicked() {
        let login = LoginManager()
        login.logIn(
            permissions: [],
            from: self
        ) { result, error in
            
            if error != nil {
                print("Process error")
            } else if ((result?.isCancelled) != nil) {
                print("Cancelled")
            } else {
                print("Logged in")
            }
        }
    }
    
    func fbAuthPassed() {
        coordinator?.goToMainTabBar()
    }
    
    func vkAuthPassed() {
        coordinator?.goToMainTabBar()
    }
    
    func skipButtonTapped() {
        coordinator?.goToMainTabBar()
    }
}
