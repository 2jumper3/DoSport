//
//  SignUpView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit

protocol SignUpViewDelegate: class {
    func saveButtonClicked(with username: String?, dob: String?, gender: String?)
    func avatarChangeButtonClicked()
    func datePickerValueChanged(_ datePicker: UIDatePicker)
}

final class SignUpView: UIView {
    
    weak var delegate: SignUpViewDelegate?
    
    private var gender: String?
    
    var avatarImage: UIImage? {
        get { avatarImageView.image }
        set { avatarImageView.image = newValue }
    }
    
    //MARK: Outlets
    
    private let avatarImageView: DSAvatartImageView = DSAvatartImageView()
    
    private lazy var userNameTextField = DSFormTextFieldView(type: .userName)
    private lazy var dobTextField = DSFormTextFieldView(type: .dob)
    
    private lazy var datePicker = DSDatePicker()
    
    private lazy var maleButton = UIButton.makeGenderButton(with: Texts.Registration.Gender.male)
    private lazy var femaleButton = UIButton.makeGenderButton(with: Texts.Registration.Gender.female)
    private lazy var saveButton = DSCommonButton(title: Texts.Registration.save, state: .normal)
    private lazy var addAvatarButton = UIButton.makeSimpleButton(title: Texts.Registration.addAvatar,
                                                                 titleColor: Colors.mainBlue)

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        datePicker.setTextField(dobTextField.getTextField())
        
        setupOutletTargets()
        setupKeyboardNotifications()
        
        addSubviews(
            avatarImageView,
            addAvatarButton,
            userNameTextField,
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
        
        dobTextField.snp.makeConstraints { $0.centerY.equalToSuperview() }
        
        userNameTextField.snp.makeConstraints { $0.bottom.equalTo(dobTextField.snp.top).offset(10) }
        
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
        
        [dobTextField, userNameTextField, dobTextField, avatarImageView, addAvatarButton, saveButton].forEach {
            $0.snp.makeConstraints { $0.centerX.equalToSuperview() }
        }
        
        [dobTextField, userNameTextField, dobTextField].forEach {
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.87)
                $0.height.equalTo(73)
            }
        }
    }
    
    deinit {
        removeObserver()
    }
}

//MARK: Public API

extension SignUpView {
    
    func updateView() {
        userNameTextField.bind() { state in
            switch state {
            case .normal: animateToIdentity()
            case .error: animateToError()
            }
        }
    }
    
    func setSaveButtonState() {
        self.setNeedsDisplay()
    }
    
    func setDateOfBirth(_ text: String) {
        dobTextField.text = text
    }
    
    func setDelegates(textField TFDelegate: UITextFieldDelegate?, datePicker DPDelegate: DSDatePickerDelegate?) {
        userNameTextField.getTextField().delegate = TFDelegate
        dobTextField.getTextField().delegate = TFDelegate
        datePicker.delegate = DPDelegate
    }
    
    func getDobTextField() -> UITextField {
        return dobTextField.getTextField()
    }
    
    func makeDobTextFieldFirstResponder() {
        dobTextField.makeTextFieldFirstResponder()
    }
    
    func removeDobTextFieldFirstResponder() {
        dobTextField.removeTextFieldFirstResponder()
    }
    
    func getUsernameTextFeild() -> UITextField {
        return userNameTextField.getTextField()
    }
    
    func getDatePicker() -> DSDatePicker {
        return datePicker
    }
}

//MARK: Private API

private extension SignUpView {
    
    func setupOutletTargets() {
        addAvatarButton.addTarget(self, action: #selector(handleAddAvatarButton))
        datePicker.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)
        maleButton.addTarget(self, action: #selector(handleMaleButton))
        femaleButton.addTarget(self, action: #selector(handleFemaleButton), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
    }
    
    func setupKeyboardNotifications() {
        addObserver(selector: #selector(handleKeybordWillShow), for: UIResponder.keyboardWillShowNotification)
        addObserver(selector: #selector(handleKeybordWillHide), for: UIResponder.keyboardWillHideNotification)
    }
    
    func animateToError() {
        UIView.animate(withDuration: 0.3) { [self] in
            [dobTextField, maleButton, femaleButton].forEach {
                $0.transform = CGAffineTransform(translationX: 0, y: 16)
            }
            layoutIfNeeded()
        }
    }
    
    func animateToIdentity() {
        UIView.animate(withDuration: 0.3) { [self] in
            [dobTextField, maleButton, femaleButton].forEach {
                $0.transform = .identity
            }
            layoutIfNeeded()
        }
    }
}

//MARK: Actions

@objc private extension SignUpView {
    
    func handleAddAvatarButton() {
        delegate?.avatarChangeButtonClicked()
    }
    
    func handleSaveButton() {
        delegate?.saveButtonClicked(
            with: userNameTextField.text,
            dob: dobTextField.text,
            gender: gender
        )
    }
    
    func handleMaleButton() {
        maleButton.bindGenderButtonState(state: .selected)
        femaleButton.bindGenderButtonState(state: .notSelected)
        self.gender = maleButton.titleLabel?.text
    }
    
    func handleFemaleButton() {
        maleButton.bindGenderButtonState(state: .notSelected)
        femaleButton.bindGenderButtonState(state: .selected)
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
