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
    private var viewModel: UserProfileEditingViewModelProtocol
    
    private let imagePicker = DSImagePicker()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Init
    
    init(viewModel: UserProfileEditingViewModelProtocol) {
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
        
        imagePicker.delegate = self
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
        viewModel.onDidDeleteUserProfile = { [unowned self] state in
            
        }
        
        viewModel.onDidEditUserProfile = { [unowned self] state in
            
        }
        
        viewModel.onDidSignOut = { [unowned self] state in
            if case .success = state {
                
            }
            
            if case .loading = state {
                
            }
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
    
    func showAvatarSourceDecideView() {
        let sourceDecideAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: Texts.Registration.deleteAvatar, style: .destructive, handler: { _ in
            print("Deletetion button pressed!") //Need to set default avatar
        })
        sourceDecideAlertController.addAction(deleteAction)
        
        let cameraAction = UIAlertAction(title: Texts.Registration.AvatarSource.camera, style: .default, handler: { _ in
            print("Camera button pressed!")
            self.imagePicker.cameraAsscessRequest()
        })
        sourceDecideAlertController.addAction(cameraAction)
        
        let albumButton = UIAlertAction(title: Texts.Registration.AvatarSource.album, style: .default, handler: { _ in
            print("Album button pressed!")
            self.imagePicker.photoGalleryAsscessRequest()
        })
        sourceDecideAlertController.addAction(albumButton)
        
        let cancelAction = UIAlertAction(title: Texts.Registration.cancel, style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        })
        sourceDecideAlertController.addAction(cancelAction)
        
        
        self.present(sourceDecideAlertController, animated: true, completion: nil)
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
        viewModel.doSignOut()
    }
    
    func deleteProfileButtonClicked() {
        viewModel.doDeleteUserProfile()
    }
    
    func saveButtonClicked(with username: String?, dob: String?, gender: String?, avatarImage: UIImage?) {
        guard let username = username,
              let dob = dob,
              let gender = gender,
              let avatarImage = avatarImage
        else {
            return
        }
        
        //        guard let avatarImageInJPEG = avatarImage.jpegData(compressionQuality: 0.5) else { return }
        
        let userData = DSModels.User.UserView(
            id: nil, // no need to change ID of current user
            username: username,
            avatarPhoto: nil,
            birthdayDate: dob,
            gender: gender,
            info: nil // TODO: this feature will be required after MVP0.
        )
        
        viewModel.doEditUserProfile(newUserData: userData)
    }
    
    func avatarChangeButtonClicked() {
        showAvatarSourceDecideView()
    }
    
    func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd / MM / yyyy"
        
        let text = dateFormatter.string(from: datePicker.date)
        userAccountEditingView.setDateOfBirth(text)
    }
}

//MARK: - ImagePickerDelegate -

extension UserAccountEditingController: ImagePickerDelegate {
    
    func imagePicker(_ imagePicker: DSImagePicker, didSelect image: UIImage) {
        userAccountEditingView.avatarImage = image
        imagePicker.dismiss()
    }
    
    func cancelButtonDidClick(on imageView: DSImagePicker) {
        imagePicker.dismiss()
    }
    
    func imagePicker(
        _ imagePicker: DSImagePicker,
        grantedAccess: Bool,
        to sourceType: UIImagePickerController.SourceType
    ) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
}
