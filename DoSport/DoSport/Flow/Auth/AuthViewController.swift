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

    // MARK: - Init
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        let view = AuthView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
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

extension AuthViewController: AuthViewDelegate {
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
