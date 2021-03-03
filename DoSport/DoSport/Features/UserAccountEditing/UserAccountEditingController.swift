//
//  UserAccountEditingController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit

final class UserAccountEditingController: UIViewController, UIGestureRecognizerDelegate {
    
    weak var coordinator: UserAccountEditingCoordinator?
    private lazy var userAccountEditingView = view as! UserAccountEditingView
    private let viewModel: UserAccountEditingViewModel

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: Init
    
    init(viewModel: UserAccountEditingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func loadView() {
        let view = UserAccountEditingView()
        view.delegate = self
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
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

private extension UserAccountEditingController {
    
    func setupNavBar() {
        title = Texts.UserAccountEditing.title
        
        guard let navController = self.navigationController as? DSNavigationController else { return }
        navController.hasSeparator(true)
        navController.interactivePopGestureRecognizer?.delegate = self
        
        let backBarButton = DSBarBackButton()
        backBarButton.addTarget(self, action: #selector(handleGoBackButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBarButton)
        
        let shareBarButton = UIButton(type: .system)
        shareBarButton.setImage(Icons.Common.share, for: .normal)
        shareBarButton.tintColor = Colors.mainBlue
        shareBarButton.addTarget(self, action: #selector(handleShareButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareBarButton)
    }
}

//MARK: Actions

@objc private extension UserAccountEditingController {
    
    func handleGoBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func handleShareButton() {
        
    }
}

//MARK: - UserSubscriberListViewDelegate -

extension UserAccountEditingController: UserAccountEditingViewDelegate {
    
    func signOutButtonCliked() {
        
    }
    
    func saveButtonClicked(with username: String?, password: String?, dob: String?, gender: String?) {
        
    }
    
    func avatarChangeButtonClicked() {
        
    }
    
    func datePickerValueChanged(_ datePicker: UIDatePicker) {
        
    }
}
