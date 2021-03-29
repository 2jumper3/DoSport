//
//  SignUpViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    weak var coordinator: SignUpCoordinator?
    private let viewModel: SignUpViewModel
    private lazy var registrationView = self.view as! SignUpView
    
    private lazy var imagePicker = DSImagePicker()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:  Init
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func loadView() {
        let view = SignUpView()
        view.delegate = self
        imagePicker.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavBar()
        self.setupViewModelBindings()
        
        registrationView.setDelegates(textField: self, datePicker: self)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        registrationView.endEditing(true)
    }
}

//MARK: Private API

private extension SignUpViewController {
    
    func setupViewModelBindings() {
        self.viewModel.onDidChangeButtonState = {  /*[unowned self] in */
            
        }
        
        self.viewModel.onDidUploadSignUpDataToServer = { /*[unowned self]*/ state in
            
        }
    }
    
    func setupNavBar() {
        self.title = Texts.Registration.navTitle
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}

//MARK: - SignUpViewDelegate -

extension SignUpViewController: SignUpViewDelegate {
    
    func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd / MM / yyyy"
        
        let text = dateFormatter.string(from: datePicker.date)
        registrationView.setDateOfBirth(text)
    }
    
    func saveButtonClicked(with username: String?, dob: String?, gender: String?) {
        viewModel.doUploadSignUpDataToServer()
    }
    
    func avatarChangeButtonClicked() {
        imagePicker.photoGalleryAsscessRequest()
    }
}

//MARK: - ImagePickerDelegate -

extension SignUpViewController: ImagePickerDelegate {
    
    func imagePicker(_ imagePicker: DSImagePicker, didSelect image: UIImage) {
        registrationView.avatarImage = image
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

//MARK: - UITextFieldDelegate -

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == registrationView.getDobTextField() {
            datePickerValueChanged(registrationView.getDatePicker())
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == registrationView.getUsernameTextFeild() {
            registrationView.makeDobTextFieldFirstResponder()
        }
        
        return true
    }
}

//MARK: - DSDatePickerDelegate -

extension SignUpViewController: DSDatePickerDelegate {
    
    func doneButtonClicked() {
        registrationView.removeDobTextFieldFirstResponder()
    }
}
