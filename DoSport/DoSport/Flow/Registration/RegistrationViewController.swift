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
    
    func saveButtonClicked(with username: String?, password: String?, dob: String?, gender: String?) {
        //создать модель с этими данными или передать данные в vm и создать модель там
        viewModel.createUser() { [weak self] in
            self?.coordinator?.goToSportTypeListModule()
        }
    }
    
    func avatarChangeButtonClicked() {
        imagePicker.photoGalleryAsscessRequest()
    }
    
    func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd / MM / yyyy"
        
        let text = dateFormatter.string(from: datePicker.date)
        registrationView.setDateOfBirth(text)
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
