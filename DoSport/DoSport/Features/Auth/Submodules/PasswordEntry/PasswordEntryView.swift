//
//  PasswordEntryView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

protocol PasswordEntryViewDelegate: class {
    func goBackButtonClicked()
    func enterButtonClicked()
    func passwordForgotButtonClicked()
    func passwordTextDidEditing(_ text: String?)
}

final class PasswordEntryView: UIView {
    
    weak var delegate: PasswordEntryViewDelegate?
    
    var avatarImage: UIImage? {
        get { avatarImageView.image }
        set { avatarImageView.image = newValue }
    }
    
    var userNameText: String? {
        get { userNameLabel.text }
        set { userNameLabel.text = newValue }
    }
    
    // MARK: Outlets
    
    private let titleLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.text = Texts.PasswordEntry.title
        $0.font = Fonts.sfProRegular(size: 32)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let userNameLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = Colors.mainBlue
        $0.text = "SomeUserName"
        $0.font = Fonts.sfProRegular(size: 18)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var avatarImageView: DSAvatartImageView = DSAvatartImageView()

    private lazy var backButton = DSBarBackButton()
    
    private(set) lazy var passwordTextView = DSPasswordTextView()
    
    private lazy var enterButton = CommonButton(title: Texts.PasswordEntry.enter, state: .disabled)
    
    private lazy var forgorPasswordButton = UIButton.makeButton(title: Texts.PasswordEntry.forgotPassword,
                                                                titleColor: Colors.mainBlue)

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        
        passwordTextView.delegate = self
        
        setupKeyboardNotifications()
        setupOutletTargets()
        
        addSubviews(backButton, titleLabel, avatarImageView, userNameLabel, passwordTextView, forgorPasswordButton, enterButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets.top).offset(45)
            $0.left.equalToSuperview().offset(13)
            $0.width.equalTo(50)
            $0.height.equalTo(30)
        }
        
        passwordTextView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-45)
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(48)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(passwordTextView.snp.top).offset(-12)
            $0.height.equalTo(28)
        }
        
        avatarImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(userNameLabel.snp.top).offset(-8)
            $0.height.equalTo(avatarImageView.snp.width)
            $0.width.equalToSuperview().multipliedBy(0.28)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(avatarImageView.snp.top).offset(-24)
            $0.height.equalTo(40)
        }
        
        forgorPasswordButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passwordTextView.snp.bottom).offset(24)
            $0.height.equalTo(24)
        }
        
        enterButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(forgorPasswordButton.snp.bottom).offset(63)
            $0.height.equalTo(48)
            $0.width.equalToSuperview().multipliedBy(0.87)
        }
    }
}

//MARK: Public API

extension PasswordEntryView {
    
    func updateEnterButtonState(state: CommonButtonState) {
        enterButton.bind(state: state)
    }
    
    func makePasswordFieldFirstResponder() {
        passwordTextView.makeTextFieldFirstResponder()
    }
    
    func removePasswordFieldFirstResponder() {
        passwordTextView.removeTextFieldFirstResponder()
    }
}

//MARK: Private API

private extension PasswordEntryView {
    
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
    
    func setupOutletTargets() {
        backButton.addTarget(self, action: #selector(handleBackButton))
        enterButton.addTarget(self, action: #selector(handleEnterButton))
        forgorPasswordButton.addTarget(self, action: #selector(handleForgotPasswordButton))
    }
}

//MARK: Actions

@objc private extension PasswordEntryView {
    
    func handleForgotPasswordButton() {
        delegate?.passwordForgotButtonClicked()
    }
    
    func handleEnterButton() {
        delegate?.enterButtonClicked()
    }
    
    func handleBackButton() {
        delegate?.goBackButtonClicked()
    }
    
    func handleKeybordWillShow(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.enterButton.transform = CGAffineTransform(translationX: 0, y: -30)
        }
    }
    
    func handleKeybordWillHide() {
        UIView.animate(withDuration: 0.3) {
            self.enterButton.transform = .identity
        }
    }
}

//MARK: - DSPasswordTextViewDelegate

extension PasswordEntryView: DSPasswordTextViewDelegate {
    
    func visibilityControlButtonClicked() {
        passwordTextView.bind()
    }
    
    func textFieldDidEditing(_ text: String?) {
        delegate?.passwordTextDidEditing(text)
    }
}
