//
//  CodeEntryViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/01/2021.
//

import UIKit

final class CodeEntryViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var coordinator: CodeEntryCoordinator?
    private let viewModel: CodeEntryViewModel
    private lazy var codeEntryView = self.view as! CodeEntryView
    
    private let phoneNumber: String
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Init
    
    init(viewModel: CodeEntryViewModel, phoneNumber: String) {
        self.viewModel = viewModel
        self.phoneNumber = phoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func loadView() {
        let view = CodeEntryView(phoneNumber)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        codeEntryView.becomeResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        codeEntryView.endEditing(true)
        codeEntryView.clearCodeTextFields()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

//MARK: - CodeEntryViewDelegate -

extension CodeEntryViewController: CodeEntryViewDelegate {
    
    func didTapCodeResentButton() {
        print(#function)
    }
    
    func didTapGoBackButton() {
        coordinator?.goBack()
    }
    
    func didAddCode(_ code: String) {
        print(code)
        coordinator?.goToRegistrationModule()
    }
}
