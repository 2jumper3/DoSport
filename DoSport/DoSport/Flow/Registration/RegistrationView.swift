//
//  RegistrationView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit

protocol RegistrationViewDelegate: class {
    func saveButtonClicked(with username: String?, password: String?, dob: String?, gender: String?)
    func avatarChangeButtonClicked()
    func datePickerValueChanged(_ datePicker: UIDatePicker)
}

final class RegistrationView: UIView {
    
    weak var delegate: RegistrationViewDelegate?
    
    private var gender: String?
    
    var avatarImage: UIImage? {
        get { avatarImageView.image }
        set { avatarImageView.image = newValue }
    }
    
    //MARK: Outlets
    
    private let avatarImageView: DSAvatartImageView = DSAvatartImageView()
    
    private lazy var userNameTextField = FormTextFieldView(type: .userName)
    private lazy var passwordTextField = FormTextFieldView(type: .password)
    private lazy var dobTextField = FormTextFieldView(type: .dob)
    
    private lazy var datePicker = DSDatePicker()
    
    private lazy var maleButton = DSButton(title: Texts.Registration.Gender.male)
    private lazy var femaleButton = DSButton(title: Texts.Registration.Gender.female)
    private lazy var saveButton = CommonButton(title: Texts.Registration.save, state: .normal)
    private lazy var addAvatarButton = UIButton.makeButton(title: Texts.Registration.addAvatar,
                                                           titleColor: Colors.mainBlue)

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        userNameTextField.getTextField().delegate = self
        passwordTextField.getTextField().delegate = self
        dobTextField.getTextField().delegate = self
        datePicker.delegate = self
        
        datePicker.setTextField(dobTextField.getTextField())
        
        setupOutletTargets()
        setupKeyboardNotifications()
        
        addSubviews(
            avatarImageView,
            addAvatarButton,
            userNameTextField,
            passwordTextField,
            dobTextField,
            saveButton,
            maleButton,
            femaleButton
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        passwordTextField.snp.makeConstraints { $0.centerY.equalToSuperview() }
        
        userNameTextField.snp.makeConstraints { $0.bottom.equalTo(passwordTextField.snp.top).offset(10) }
        
        addAvatarButton.snp.makeConstraints {
            $0.bottom.equalTo(userNameTextField.snp.top).offset(-20)
            $0.height.equalTo(24)
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        avatarImageView.snp.makeConstraints {
            $0.bottom.equalTo(addAvatarButton.snp.top).offset(-10)
            $0.height.equalTo(avatarImageView.snp.width)
            $0.width.equalToSuperview().multipliedBy(0.28)
        }
        
        dobTextField.snp.makeConstraints { $0.top.equalTo(passwordTextField.snp.bottom).offset(-10) }
        
        saveButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaInsets.bottom).offset(-10)
            $0.height.equalTo(48)
            $0.width.equalToSuperview().multipliedBy(0.87)
        }
        
        maleButton.snp.makeConstraints {
            $0.top.equalTo(dobTextField.snp.bottom).offset(-10)
            $0.left.equalTo(dobTextField.snp.left)
            $0.height.equalTo(48)
            $0.width.equalTo(dobTextField.snp.width).multipliedBy(0.48)
        }
        
        femaleButton.snp.makeConstraints {
            $0.right.equalTo(dobTextField.snp.right)
            $0.height.width.centerY.equalTo(maleButton)
        }
        
        [passwordTextField, userNameTextField, dobTextField, avatarImageView, addAvatarButton, saveButton].forEach {
            $0.snp.makeConstraints { $0.centerX.equalToSuperview() }
        }
        
        [passwordTextField, userNameTextField, dobTextField].forEach {
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.87)
                $0.height.equalTo(73)
            }
        }
    }
}

//MARK: Public API

extension RegistrationView {
    
    func updateView() {
        userNameTextField.bind() { state in
            switch state {
            case .normal: animateToIdentity()
            case .error: animateToError()
            }
        }
    }
    
    func setDateOfBirth(_ text: String) {
        dobTextField.text = text
    }
}

//MARK: Private API

private extension RegistrationView {
    
    func setupOutletTargets() {
        addAvatarButton.addTarget(self, action: #selector(handleAddAvatarButton))
        datePicker.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)
        maleButton.addTarget(self, action: #selector(handleMaleButton))
        femaleButton.addTarget(self, action: #selector(handleFemaleButton), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
    }
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeybordWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeybordWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func animateToError() {
        UIView.animate(withDuration: 0.3) { [self] in
            [passwordTextField, dobTextField, maleButton, femaleButton].forEach {
                $0.transform = CGAffineTransform(translationX: 0, y: 16)
            }
            layoutIfNeeded()
        }
    }
    
    func animateToIdentity() {
        UIView.animate(withDuration: 0.3) { [self] in
            [passwordTextField, dobTextField, maleButton, femaleButton].forEach {
                $0.transform = .identity
            }
            layoutIfNeeded()
        }
    }
}

//MARK: Actions

@objc private extension RegistrationView {
    
    func handleAddAvatarButton() {
        delegate?.avatarChangeButtonClicked()
    }
    
    func handleSaveButton() {
        delegate?.saveButtonClicked(
            with: userNameTextField.text,
            password: passwordTextField.text,
            dob: dobTextField.text,
            gender: gender
        )
    }
    
    func handleMaleButton() {
        maleButton.bind(state: .seleted)
        femaleButton.bind(state: .normal)
        self.gender = maleButton.titleLabel?.text
    }
    
    func handleFemaleButton() {
        maleButton.bind(state: .normal)
        femaleButton.bind(state: .seleted)
        self.gender = maleButton.titleLabel?.text
    }
    
    func dateValueChanged() {
        delegate?.datePickerValueChanged(self.datePicker)
    }
    
    func handleKeybordWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = (
                userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            )?.cgRectValue
        else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.height * 0.5)
        }
    }
    
    func handleKeybordWillHide() {
        UIView.animate(withDuration: 0.3) { self.transform = .identity }
    }
}

//MARK: - UITextFieldDelegate -

extension RegistrationView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dobTextField.getTextField() {
            delegate?.datePickerValueChanged(datePicker)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField.getTextField() {
            passwordTextField.makeTextFieldFirstResponder()
        } else if textField == passwordTextField.getTextField() {
            dobTextField.makeTextFieldFirstResponder()
        }
        return true
    }
}

//MARK: - DSDatePickerDelegate -

extension RegistrationView: DSDatePickerDelegate {
    
    func doneButtonClicked() {
        dobTextField.removeTextFieldFirstResponder()
    }
}
