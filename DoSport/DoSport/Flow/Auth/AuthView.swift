//
//  AuthView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit
import SnapKit

protocol AuthViewDelegate: AnyObject {
    func submitButtonTapped()
    func regionSelectionButtonTapped()
}

final class AuthView: UIView {
    
    weak var delegate: AuthViewDelegate?
    
    private let logoImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = Icons.Auth.logo
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = { // TODO: Make bold. Task at: https://trello.com/b/B0RlPzN6/dosport-ios
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = Texts.Auth.enter
        $0.textColor = .white
        $0.font = Fonts.sfProRegular(size: 32)
        return $0
    }(UILabel())
    
    private let descriptionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
        $0.text = Texts.Auth.description
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textColor = .white
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var phoneNumberAddView: PhoneNumberAddView = {
        $0.addButtonTarget(self, action: #selector(handleRegionSelectionButton))
        return $0
    }(PhoneNumberAddView())
    
    private let regulationsLabel: UILabel = {
        let upperTextAttrs: [NSAttributedString.Key: Any] = [.foregroundColor: Colors.dirtyBlue]
        let bottomTextAttrs: [NSAttributedString.Key: Any] = [.foregroundColor: Colors.mainBlue]

        let text = NSMutableAttributedString(
            string: Texts.Auth.Regulations.upper,
            attributes: upperTextAttrs
        )
        let bottomText = NSMutableAttributedString(
            string: Texts.Auth.Regulations.bottom, attributes: bottomTextAttrs
        )

        text.append(bottomText)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 3
        $0.attributedText = text
        $0.textAlignment = .center
        $0.font = Fonts.sfProRegular(size: 14)
        return $0
    }(UILabel())
    
    private lazy var submitButton: CommonButton = {
        $0.addTarget(self, action: #selector(handleSubmitButton), for: .touchUpInside)
        return $0
    }(CommonButton(title: Texts.Auth.submit, state: .disabled))
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
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
        
        addSubviews(logoImageView,titleLabel,descriptionLabel,phoneNumberAddView,regulationsLabel,submitButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        phoneNumberAddView.removeFirstResponder()
        perform(#selector(handleKeybordWillHide), with: nil, afterDelay: 0.1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.15)
            $0.height.equalTo(logoImageView.snp.width)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-67)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-24)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(phoneNumberAddView.snp.top).offset(-12)
            $0.height.equalTo(phoneNumberAddView.snp.height).multipliedBy(0.7)
            $0.width.centerX.equalTo(phoneNumberAddView)
        }
        
        phoneNumberAddView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(48)
        }
        
        regulationsLabel.snp.makeConstraints {
            $0.top.equalTo(phoneNumberAddView.snp.bottom).offset(16)
            $0.width.centerX.equalTo(phoneNumberAddView)
            $0.height.equalTo(descriptionLabel)
        }
        
        submitButton.snp.makeConstraints {
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
                $0.width.centerX.height.equalTo(phoneNumberAddView)
            } else {
                $0.bottom.equalToSuperview().offset(-16)
                $0.width.centerX.height.equalTo(phoneNumberAddView)
            }
        }
    }
    
    //MARK: - Actions
    
    @objc private func handleSubmitButton() {
        delegate?.submitButtonTapped()
    }
    
    @objc private func handleRegionSelectionButton() {
        delegate?.regionSelectionButtonTapped()
    }
    
    @objc private func handleKeybordWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = (
                userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            )?.cgRectValue
        else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.submitButton.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.height)
        }
    }
    
    @objc private func handleKeybordWillHide() {
        UIView.animate(withDuration: 0.3) {
            self.submitButton.transform = .identity
        }
    }
}

