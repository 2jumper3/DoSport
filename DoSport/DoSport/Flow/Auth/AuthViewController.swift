//
//  AuthViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

@available(iOS 13.0, *)
final class AuthViewController: UIViewController {
    
    weak var coordinator: AuthCoordinator?
    private let viewModel: AuthViewModel
    
    private let authManager: AuthManagerProtocol?
    
    private lazy var authView = self.view as! AuthView
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(viewModel: AuthViewModel, authManeger: AuthManagerProtocol?) {
        self.viewModel = viewModel
        self.authManager = authManeger
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

    }
    
    /// Hide navigation bar before this ViewController will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    /// Show navigation bar after this ViewController did disappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        coordinator?.removeDependency(coordinator)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        authView.becomeTextFieldResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        authView.removeTextFieldResponder()
    }
}

//MARK: - AuthViewDelegate -

@available(iOS 13.0, *)
extension AuthViewController: AuthViewDelegate {

    func appleSignInButtomClicked() {
        authManager?.signInWithApple(for: self)
    }
    
    func regionSelectionButtonTapped() {
        coordinator?.goToCountryListModule { callingCode in
            self.authView.bind(callingCode: callingCode)
        }
    }
   
    func submitButtonTapped(with text: String) {
        viewModel.checkIfNumberExists { [weak self] authResult in
            switch authResult {
            case .registred:
                // TODO: when back-end is ready, provide registred `User` here for further use
                self?.coordinator?.goToPasswordEntryModule()
            case .notRegistred:
                self?.coordinator?.goToCodeEntryModule(text)
            }
        }
    }
}
