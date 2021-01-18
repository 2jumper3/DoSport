//
//  PasswordEntryViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class PasswordEntryViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var coordinator: PasswordEntryCoordinator?
    private let viewModel: PasswordEntryViewModel
    
    private lazy var passwordEntryView = self.view as! PasswordEntryView
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Init
    
    init(viewModel: PasswordEntryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    
    override func loadView() {
        let view = PasswordEntryView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        passwordEntryView.passwordTextView.textField.addTarget(
            self,
            action: #selector(handlePasswordTextFieldEditing),
            for: .editingChanged
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordEntryView.endEditing(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        passwordEntryView.endEditing(true)
    }
}

//MARK: - PasswordEntryViewDelegate

extension PasswordEntryViewController: PasswordEntryViewDelegate {
    func didTapGoBackButton() {
        coordinator?.goBack()
    }
    
    func didTapEnterButton() {
        viewModel.checkPassword { [weak self] in
            self?.coordinator?.goToHomeModule()
        }
    }
    
    func didTapPasswordForgotButton() {
        
    }
}

//MARK: - Actions

@objc
private extension PasswordEntryViewController {
    func handlePasswordTextFieldEditing(_ textField: UITextField) {
        if let text = textField.text, text.count > 3 {
            passwordEntryView.updateEnterButtonState(state: .normal)
        } else {
            passwordEntryView.updateEnterButtonState(state: .disabled)
        }
    }
}
