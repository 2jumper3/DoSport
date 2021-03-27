//
//  UserReportMessageController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

final class UserReportMessageController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: UserReportMessageCoordinator?
    private let viewModel: UserReportMessageViewModel
    private lazy var userReportMessageView = view as! UserReportMessageView
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(viewModel: UserReportMessageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = UserReportMessageView()
        view.delegate = self
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        self.userReportMessageView.setDelegates(textField: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.removeDependency(coordinator)
    }
}

//MARK: Private API

private extension UserReportMessageController {
    
    func setupNavBar() {
        title = Texts.Common.reportAProblem
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        let backBarButton = UIButton.makeBarButton()
        backBarButton.addTarget(self, action: #selector(handleGoBackButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
    }
}

//MARK: Actions

@objc private extension UserReportMessageController {
    
    func handleGoBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - UserReportMessageViewDelegate -

extension UserReportMessageController: UserReportMessageViewDelegate {
    
    func sendButtonClicked() {
        
    }
}

//MARK: - UITextViewDelegate -

extension UserReportMessageController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.text = Texts.Common.reportAProblem
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        
        if text != Texts.Common.reportAProblem, !text.isEmpty {
            userReportMessageView.bindButtonState(.normal)
        } else if text.isEmpty, text == "" {
            userReportMessageView.bindButtonState(.disabled)
        }
    }
}

