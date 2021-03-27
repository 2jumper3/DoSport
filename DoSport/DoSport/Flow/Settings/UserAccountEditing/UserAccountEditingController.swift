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
    private var viewModel: UserAccountEditingViewModel

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
        setupViewModelBindings()
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
    
    func setupViewModelBindings() {
        viewModel.onDidDeleteUserProfile = { [unowned self] data in
            
        }

        viewModel.onDidEditUserProfile = { [unowned self] data in
            
        }
    }
    
    func setupNavBar() {
        title = Texts.UserAccountEditing.title
        
        guard let navController = self.navigationController as? DSNavigationController else { return }
        navController.hasSeparator(true)
        navController.interactivePopGestureRecognizer?.delegate = self
        
        let backBarButton = UIButton.makeBarButton()
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
    
    func deleteProfileButtonClicked() {
        viewModel.doDeleteUserProfile(request: .init())
    }

    func saveButtonClicked(with username: String?, dob: String?, gender: String?, avatarImage: UIImage?) {
        guard let username = username,
              let dob = dob,
              let gender = gender,
              let avatarImage = avatarImage
        else {
            return
        }
        
        guard let avatarImageInJPEG = avatarImage.jpegData(compressionQuality: 0.5) else { return }
        
        let userData = DSModels.User.UserView(
            id: nil, // no need to change ID of current user
            username: username,
            avatarPhoto: avatarImageInJPEG,
            birthdayDate: dob,
            gender: gender,
            info: nil // TODO: this feature will be required after MVP0.
        )
        
        viewModel.doEditUserProfile(request: .init(user: userData))
    }
    
    func avatarChangeButtonClicked() {
        
    }
    
    func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd / MM / yyyy"
        
        let text = dateFormatter.string(from: datePicker.date)
        userAccountEditingView.setDateOfBirth(text)
    }
}
