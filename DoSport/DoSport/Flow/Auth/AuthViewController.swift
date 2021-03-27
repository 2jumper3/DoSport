//
//  AuthViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

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
        
        setupViewModelBindings()
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

//MARK: Private API

private extension AuthViewController {
    
    func setupViewModelBindings() {
        viewModel.onDidSignUpWithSocialMedia = { /*[unowned self]*/ data in
            switch data.state {
            case .loading:
                break
            case .failed:
                break
            case .success:
                break
            }
        }
        
        viewModel.onDidSendSignUpDataToServer = { data in
            
        }
    }
}

//MARK: - AuthViewDelegate -

extension AuthViewController: AuthViewDelegate {
    func skipButtonTapped() {
        
    }
    
    func vkAuthButtonClicked() {
        coordinator?.openVkAuthView(completion: {
            self.coordinator?.dismissWKWebView()
            self.coordinator?.goToMainTabBar()
        })
        viewModel.doSignUpWithSocialMedia(request: .init(socialmediaType: .vkontakte, viewController: nil))
    }
    
    func fbAuthClicked() {
        viewModel.doSignUpWithSocialMedia(request: .init(socialmediaType: .facebook, viewController: self))
    }
    
    func googleAuthButtonClicked() {
        
        viewModel.doSignUpWithSocialMedia(request: .init(socialmediaType: .google, viewController: self))
    }
    
    func appleAuthButtonClicked() {
        viewModel.doSignUpWithSocialMedia(request: .init(socialmediaType: .apple, viewController: nil))
    }
}
