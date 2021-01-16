//
//  RegistrationView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit
import SnapKit

protocol RegistrationViewDelegate: class {
    func didTapSaveButton(username: String?, password: String?, dob: String?, gender: String?)
    func didTapAvatarChangeButton()
    func didChangeDatePickerValue(_ datePicker: UIDatePicker)
}

final class RegistrationView: UIView {
    
    weak var delegate: RegistrationViewDelegate?
    
    var avatarImage: UIImage? {
        get { avatarImageView.image }
        set { avatarImageView.image = newValue }
    }
    
    private lazy var avatarImageView = (AvatartImageView(image: Icons.Registration.avatarDefault))
    
    private lazy var addAvatarButton: UIButton = {
        $0.addTarget(self, action: #selector(handleAddAvatarButton), for: .touchUpInside)
        return $0
    }(UIButton.makeButton(title: Texts.Registration.addAvatar, titleColor: Colors.mainBlue))
    
    private lazy var userNameTextField = FormTextFieldView(type: .userName)
    private lazy var passwordTextField = FormTextFieldView(type: .password)
    private lazy var dobTextField = FormTextFieldView(type: .dob)
    
    private lazy var datePicker: DSDatePicker = {
        $0.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        $0.setTextField(dobTextField.textField)
        $0.onDoneButtonTap = { [weak self ] in
            self?.dobTextField.textField.resignFirstResponder()
        }
        return $0
    }(DSDatePicker())
    
    private var gender: String?
    
    private lazy var maleButton: DSButton = {
        $0.addTarget(self, action: #selector(handleMaleButton), for: .touchUpInside)
        return $0
    }(DSButton(title: Texts.Registration.Gender.male))
    
    private lazy var femaleButton: DSButton = {
        $0.addTarget(self, action: #selector(handleFemaleButton), for: .touchUpInside)
        return $0
    }(DSButton(title: Texts.Registration.Gender.female))
    
    private lazy var saveButton: CommonButton = {
        $0.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        return $0
    }(CommonButton(title: Texts.Registration.save, state: .normal))
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        userNameTextField.textField.delegate = self
        passwordTextField.textField.delegate = self
        dobTextField.textField.delegate = self
        
        addSubviews(avatarImageView,addAvatarButton,userNameTextField,passwordTextField,dobTextField,saveButton,maleButton,femaleButton)
        
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

//MARK: - Public methods

extension RegistrationView {
    func updateView() {
        userNameTextField.bind() { state in
            switch state {
            case .normal: performErrorAnimationToIdentity()
            case .error: performErrorAnimation()
            }
        }
    }
    
    func setDateOfBirth(_ text: String) {
        dobTextField.textField.text = text
    }
}

//MARK: - Private methods

private extension RegistrationView {
    func performErrorAnimation() {
        UIView.animate(withDuration: 0.3) { [self] in
            [passwordTextField, dobTextField, maleButton, femaleButton].forEach {
                $0.transform = CGAffineTransform(translationX: 0, y: 16)
            }
            layoutIfNeeded()
        }
    }
    
    func performErrorAnimationToIdentity() {
        UIView.animate(withDuration: 0.3) { [self] in
            [passwordTextField, dobTextField, maleButton, femaleButton].forEach {
                $0.transform = .identity
            }
            layoutIfNeeded()
        }
    }
}

//MARK: - Actions

@objc extension RegistrationView {
    func handleAddAvatarButton() {
        delegate?.didTapAvatarChangeButton()
    }
    
    func handleSaveButton() {
        delegate?.didTapSaveButton(
            username: userNameTextField.text,
            password: passwordTextField.text,
            dob: dobTextField.text,
            gender: gender
        )
    }
    
    func handleMaleButton() {
        maleButton.bind(state: .seleted)
        femaleButton.bind(state: .normal)
        gender = maleButton.titleLabel?.text
    }
    
    func handleFemaleButton() {
        maleButton.bind(state: .normal)
        femaleButton.bind(state: .seleted)
        gender = maleButton.titleLabel?.text
    }
    
    func dateChanged() {
        delegate?.didChangeDatePickerValue(self.datePicker)
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
        UIView.animate(withDuration: 0.3) {
            self.transform = .identity
        }
    }
}

//MARK: - UITextFieldDelegate

extension RegistrationView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dobTextField.textField {
            delegate?.didChangeDatePickerValue(datePicker)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField.textField {
            passwordTextField.textField.becomeFirstResponder()
        } else if textField == passwordTextField.textField {
            dobTextField.textField.becomeFirstResponder()
        }
        return true
    }
}
