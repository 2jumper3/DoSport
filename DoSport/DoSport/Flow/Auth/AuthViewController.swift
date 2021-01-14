//
//  AuthViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

final class AuthViewController: UIViewController {
    
    var coordinator: AuthCoordinator?
    private let viewModel: AuthViewModel
    
    private lazy var authView = self.view as! AuthView

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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Hide navigation bar before this ViewController will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    /// Show navigation bar after this ViewController did disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        authView.removeTextFieldResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        authView.becomeTextFieldResponder()
    }
}

extension AuthViewController: AuthViewDelegate {
    func regionSelectionButtonTapped() {
        coordinator?.goToCountryListModule { callingCode in
            self.authView.bind(callingCode: callingCode)
        }
    }
   
    func submitButtonTapped(with text: String) {
        print(text)
        coordinator?.goToCodeEntryModule()
    }
}
