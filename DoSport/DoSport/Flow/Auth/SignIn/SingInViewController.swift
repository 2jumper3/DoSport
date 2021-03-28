//
//  SingInViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

final class SingInViewController: UIViewController {
    
    private let viewModel: SignInViewModel
    private lazy var customView = self.view as! SingInView
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = SingInView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupButtonTargets()
        self.setupViewModelBindings()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

//MARK: Private API

private extension SingInViewController {
    
    func setupButtonTargets() {
        self.customView.skipButton.addTarget(self, action: #selector(handleSkipButton))
        self.customView.appleAuthButton.addTarget(self, action: #selector(handleAppleAuthButton))
        self.customView.googleAuthButton.addTarget(self, action: #selector(handleGoogleAuthButton))
        self.customView.vkAuthButton.addTarget(self, action: #selector(handleVKAuthButton))
        self.customView.fbAuthButton.addTarget(self, action: #selector(handleFBAuthButton))
    }
    
    func setupViewModelBindings() {
        viewModel.onSigningUpWithSocialMedia = { /*[unowned self]*/ state in
            switch state {
            case .loading:
                break
            case .failed:
                break
            case .success:
                break
            }
        }
        
        viewModel.onSendingSignUpDataToServer = { state in
            
        }
        
        viewModel.onLogining = { [unowned self] state in
            switch state {
            case .loading:
                break
            case .failed:
                break
            case .success:
                self.viewModel.goToSignUpModuleRequest()
            }
        }
    }
}

//MARK: Actions

@objc private extension SingInViewController {
    
    func handleSkipButton() {
        //        coordinator?.goToMainTabBar()
        //        coordinator?.goToRegistrationModule()
        
        // will be replaced by social media auth
        viewModel.doLogin(
            with: .init(
                username: "admin",
                password: "admin"
            )
        )
    }
    
    func handleFBAuthButton() {
        viewModel.doSignUpWithSocialMedia(.facebook, viewController: self)
    }
    
    func handleVKAuthButton() {
        viewModel.doSignUpWithSocialMedia(.vkontakte, viewController: nil)
    }
    
    func handleGoogleAuthButton() {
        viewModel.doSignUpWithSocialMedia(.google, viewController: self)
    }
    
    func handleAppleAuthButton() {
        viewModel.doSignUpWithSocialMedia(.apple, viewController: nil)
    }
}
