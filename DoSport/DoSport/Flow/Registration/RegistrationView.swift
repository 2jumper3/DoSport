//
//  RegistrationView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit
import SnapKit

protocol RegistrationViewDelegate: class {
    func didTapSave()
    func didTapMale()
    func didTapFemale()
}

final class RegistrationView: UIView {
    
    weak var delegate: RegistrationViewDelegate?
    
    private var passwordYAnchor: NSLayoutConstraint??
    
    private lazy var avatarImageView: UIImageView = {
        $0.layer.borderColor = Colors.dirtyBlue.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = Icons.Registration.avatarDefault
        return $0
    }(UIImageView())
    
    private lazy var addAvatarButton: UIButton = {
        $0.titleLabel?.textColor = Colors.mainBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(Texts.Registration.addAvatar, for: .normal)
        $0.titleLabel?.font = Fonts.sfProRegular(size: 16)
        $0.titleLabel?.textAlignment = .center
        $0.addTarget(self, action: #selector(handleAddAvatarButton), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    private lazy var userNameTextField = FormTextFieldView(type: .userName)
    private lazy var passwordTextField = FormTextFieldView(type: .password)
    private lazy var dobTextField = FormTextFieldView(type: .dob)
    
    private lazy var maleButton: DSButton = {
        $0.addTarget(self, action: #selector(handleMaleButton), for: .touchUpInside)
        return $0
    }(DSButton())
    
    private lazy var femaleButton: DSButton = {
        $0.addTarget(self, action: #selector(handleFemaleButton), for: .touchUpInside)
        return $0
    }(DSButton())
    
    
    private lazy var saveButton: CommonButton = {
        $0.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        return $0
    }(CommonButton(title: Texts.Registration.save, state: .normal))
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        addSubviews(avatarImageView, addAvatarButton, userNameTextField, passwordTextField, dobTextField, saveButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 73),
            passwordTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.87),
            
            userNameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            userNameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 10),
            userNameTextField.heightAnchor.constraint(equalToConstant: 73),
            userNameTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.87),
            
            addAvatarButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addAvatarButton.bottomAnchor.constraint(equalTo: userNameTextField.topAnchor, constant: -20),
            addAvatarButton.heightAnchor.constraint(equalToConstant: 24),
            addAvatarButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: addAvatarButton.topAnchor, constant: -10),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.28),
            
            dobTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            dobTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: -10),
            dobTextField.heightAnchor.constraint(equalToConstant: 73),
            dobTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.87),
            
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 48),
            saveButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.87),
        ])
        
        passwordYAnchor = passwordTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20)
        passwordYAnchor??.isActive = true
    }
}

//MARK: - Public methods

extension RegistrationView {
    func updateView() {
        userNameTextField.bind()
        switch userNameTextField.state {
        case .normal:
            animateToIdentity()
        case .error:
            animate()
        }
    }
}

//MARK: - Private methods

private extension RegistrationView {
    func animate() {
        UIView.animate(withDuration: 0.3) {
            self.passwordTextField.transform = CGAffineTransform(translationX: 0, y: 14)
            self.dobTextField.transform = CGAffineTransform(translationX: 0, y: 14)
            self.layoutIfNeeded()
        }
    }
    
    func animateToIdentity() {
        UIView.animate(withDuration: 0.3) {
            self.passwordTextField.transform = .identity
            self.dobTextField.transform = .identity
            self.layoutIfNeeded()
        }
    }
}

//MARK: - Actions

@objc extension RegistrationView {
    func handleAddAvatarButton() {
        
    }
    
    func handleSaveButton() {
        updateView()
        delegate?.didTapSave()
    }
    
    func handleMaleButton() {
        maleButton.bind()
        delegate?.didTapMale()
    }
    
    func handleFemaleButton() {
        femaleButton.bind()
        delegate?.didTapFemale()
    }
}
