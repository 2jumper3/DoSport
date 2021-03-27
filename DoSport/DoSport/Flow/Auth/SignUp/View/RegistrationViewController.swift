//
//  RegistrationViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    weak var coordinator: RegistrationCoordinator?
    private let viewModel: RegistrationViewModel
    private lazy var registrationView = self.view as! RegistrationView
    
    private lazy var imagePicker = ImagePicker()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:  Init
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func loadView() {
        let view = RegistrationView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Texts.Registration.navTitle
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        imagePicker.delegate = self
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

//MARK: - RegistrationViewDelegate -

extension RegistrationViewController: RegistrationViewDelegate {
    
    func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd / MM / yyyy"
        
        let text = dateFormatter.string(from: datePicker.date)
        registrationView.setDateOfBirth(text)
    }
    
    func saveButtonClicked(with username: String?, dob: String?, gender: String?) {
        viewModel.createUser() { [weak self] in
            self?.coordinator?.goToSportTypeListModule {
                self?.coordinator?.closeSportTypeGridModule()
            }
        }
    }
    
    func avatarChangeButtonClicked() {
        imagePicker.photoGalleryAsscessRequest()
    }
}

//MARK: - ImagePickerDelegate -

extension RegistrationViewController: ImagePickerDelegate {
    
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        registrationView.avatarImage = image
        imagePicker.dismiss()
    }
    
    func cancelButtonDidClick(on imageView: ImagePicker) {
        imagePicker.dismiss()
    }
    
    func imagePicker(
        _ imagePicker: ImagePicker,
        grantedAccess: Bool,
        to sourceType: UIImagePickerController.SourceType
    ) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
}

//MARK: - UITextFieldDelegate -

extension RegistrationViewController: UITextFieldDelegate {
    
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

extension RegistrationViewController: DSDatePickerDelegate {
    
    func doneButtonClicked() {
        registrationView.removeDobTextFieldFirstResponder()
    }
}
