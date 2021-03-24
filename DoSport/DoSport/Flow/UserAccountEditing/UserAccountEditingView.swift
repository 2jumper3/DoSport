//
//  UserAccountEditingView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit

protocol UserAccountEditingViewDelegate: class {
    func signOutButtonCliked()
    func deleteProfileButtonClicked()
    func saveButtonClicked(with username: String?, dob: String?, gender: String?, avatarImage: UIImage?)
    func avatarChangeButtonClicked()
    func datePickerValueChanged(_ datePicker: UIDatePicker)
}
    
final class UserAccountEditingView: UIView {
    
    weak var delegate: UserAccountEditingViewDelegate?
    
    private var gender: String?
    
    var avatarImage: UIImage? {
        get { avatarImageView.image }
        set { avatarImageView.image = newValue }
    }
    
    //MARK: Outlets
    
    private let avatarImageView: DSAvatartImageView = DSAvatartImageView()
    
    private lazy var userNameTextField = FormTextFieldView(type: .userName)
    private lazy var dobTextField = FormTextFieldView(type: .dob)
    
    private lazy var datePicker = DSDatePicker()
    
    private lazy var maleButton = DSButton(title: Texts.Registration.Gender.male)
    private lazy var femaleButton = DSButton(title: Texts.Registration.Gender.female)
    private lazy var saveButton = CommonButton(title: Texts.Registration.save, state: .normal, isHidden: false)
    private lazy var addAvatarButton = UIButton.makeButton(title: Texts.Registration.addAvatar,
                                                           titleColor: Colors.mainBlue)
    
    private lazy var signOutButton: DSButtonWithIcon = .init(
        img: Icons.UserProfileEdit.logout,
        txt: Texts.UserAccountEditing.signOut,
        textColor: Colors.mainBlue,
        imageColor: Colors.mainBlue,
        isBindable: false)
    
    private lazy var signoutBottomSeparatorView: DSSeparatorView = DSSeparatorView()
    
    private lazy var deleteProfileButton: DSButtonWithIcon = .init(
        img: Icons.UserProfileEdit.delete,
        txt: Texts.UserAccountEditing.deleteProfile,
        textColor: Colors.mainBlue,
        imageColor: Colors.mainBlue,
        isBindable: false)

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        setupDelegates()
        datePicker.setTextField(dobTextField.getTextField())
        
        setupButtonTargets()
        setupKeyboardNotifications()
        
        addSubviews(
            avatarImageView,
            addAvatarButton,
            userNameTextField,
            dobTextField,
            saveButton,
            maleButton,
            femaleButton,
            signOutButton,
            signoutBottomSeparatorView,
            deleteProfileButton
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let textFieldsHeight: CGFloat
        let buttonsHeight: CGFloat
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2:
            textFieldsHeight = 65
            buttonsHeight = 42
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini:
            textFieldsHeight = 70
            buttonsHeight = 45
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max:
            textFieldsHeight = 73
            buttonsHeight = 48
        }
        
        dobTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        
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
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaInsets.bottom).offset(-UIDevice.getDeviceRelatedTabBarHeight()-10)
            $0.height.equalTo(buttonsHeight)
            $0.width.equalToSuperview().multipliedBy(0.87)
        }
        
        maleButton.snp.makeConstraints {
            $0.top.equalTo(dobTextField.snp.bottom).offset(-10)
            $0.left.equalTo(dobTextField.snp.left)
            $0.height.equalTo(buttonsHeight)
            $0.width.equalTo(dobTextField.snp.width).multipliedBy(0.48)
        }
        
        femaleButton.snp.makeConstraints {
            $0.right.equalTo(dobTextField.snp.right)
            $0.height.width.centerY.equalTo(maleButton)
        }
        
        signOutButton.snp.makeConstraints {
            $0.top.equalTo(femaleButton.snp.bottom).offset(25)
            $0.left.equalTo(maleButton.snp.left)
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(buttonsHeight)
        }
        
        signoutBottomSeparatorView.snp.makeConstraints {
            $0.top.equalTo(signOutButton.snp.bottom).offset(4)
            $0.height.equalTo(1)
            $0.right.equalToSuperview()
            $0.left.equalTo(signOutButton.snp.left).offset(15)
        }
        
        deleteProfileButton.snp.makeConstraints {
            $0.top.equalTo(signoutBottomSeparatorView.snp.bottom).offset(4)
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(buttonsHeight)
            $0.left.equalTo(signOutButton.snp.left)
        }
        
        [dobTextField, userNameTextField, dobTextField, avatarImageView, addAvatarButton, saveButton].forEach {
            $0.snp.makeConstraints { $0.centerX.equalToSuperview() }
        }
        
        [dobTextField, userNameTextField, dobTextField].forEach {
            $0.snp.makeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.87)
                $0.height.equalTo(textFieldsHeight)
            }
        }
    }
    
    deinit {
        removeObserver()
    }
}

//MARK: Public API

extension UserAccountEditingView {
    
    func setDateOfBirth(_ text: String?) {
        self.dobTextField.text = text
    }
}

//MARK: Private API

private extension UserAccountEditingView {
    
    func setupDelegates() {
        userNameTextField.getTextField().delegate = self
        dobTextField.getTextField().delegate = self
        datePicker.delegate = self
    }
    
    func setupButtonTargets() {
        addAvatarButton.addTarget(self, action: #selector(handleAddAvatarButton))
        datePicker.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)
        maleButton.addTarget(self, action: #selector(handleMaleButton))
        femaleButton.addTarget(self, action: #selector(handleFemaleButton))
        saveButton.addTarget(self, action: #selector(handleSaveButton))
        signOutButton.addTarget(self, action: #selector(handleSignOutButton))
        deleteProfileButton.addTarget(self, action: #selector(handleDeleteProfileButton))
    }
    
    func setupKeyboardNotifications() {
        addObserver(selector: #selector(handleKeybordWillShow), for: UIResponder.keyboardWillShowNotification)
        addObserver(selector: #selector(handleKeybordWillHide), for: UIResponder.keyboardWillHideNotification)
    }
}

//MARK: Actions

@objc private extension UserAccountEditingView {
    
    func handleDeleteProfileButton() {
        delegate?.deleteProfileButtonClicked()
    }
    
    func handleSignOutButton() {
        delegate?.signOutButtonCliked()
    }
    
    func handleAddAvatarButton() {
        delegate?.avatarChangeButtonClicked()
    }
    
    func handleSaveButton() {
        delegate?.saveButtonClicked(
            with: userNameTextField.text,
            dob: dobTextField.text,
            gender: gender,
            avatarImage: avatarImage
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

extension UserAccountEditingView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dobTextField.getTextField() {
            delegate?.datePickerValueChanged(datePicker)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField.getTextField() {
            dobTextField.makeTextFieldFirstResponder()
        }
        
        return true
    }
}

//MARK: - DSDatePickerDelegate -

extension UserAccountEditingView: DSDatePickerDelegate {
    
    func doneButtonClicked() {
        dobTextField.removeTextFieldFirstResponder()
    }
}

