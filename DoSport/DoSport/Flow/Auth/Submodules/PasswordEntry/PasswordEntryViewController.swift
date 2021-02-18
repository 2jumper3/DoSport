//
//  PasswordEntryViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

final class PasswordEntryViewController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: PasswordEntryCoordinator?
    private let viewModel: PasswordEntryViewModel
    private lazy var passwordEntryView = self.view as! PasswordEntryView
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Init
    
    init(viewModel: PasswordEntryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func loadView() {
        let view = PasswordEntryView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordEntryView.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        passwordEntryView.makePasswordFieldFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        passwordEntryView.removePasswordFieldFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
}

//MARK: - PasswordEntryViewDelegate -

extension PasswordEntryViewController: PasswordEntryViewDelegate {
    
    func goBackButtonClicked() {
        coordinator?.goBack()
    }
    
    func enterButtonClicked() {
        viewModel.checkPassword { [weak self] in
            self?.coordinator?.goToFeedModule()
        }
    }
    
    func passwordForgotButtonClicked() {
        print(#function)
    }
    
    func passwordTextDidEditing(_ text: String?) {
        guard let text = text else {
            debugPrint("######## text nil - ", #function)
            return
        }
        
        if text.count > 3 {
            passwordEntryView.updateEnterButtonState(state: .normal)
        } else {
            passwordEntryView.updateEnterButtonState(state: .disabled)
        }
    }
}
