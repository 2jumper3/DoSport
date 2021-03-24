//
//  AuthView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit
import SnapKit
import FBSDKLoginKit
import GoogleSignIn

protocol AuthViewDelegate: AnyObject {
    func submitButtonTapped(with text: String)
    func regionSelectionButtonTapped()
    func fbAuthPassed()
    func fbAuthClicked()
    func vkAuthButtonClicked()
}

final class AuthView: UIView,LoginButtonDelegate {

    weak var delegate: AuthViewDelegate?
    
    private lazy var fbLoginBtn: CustomAuthButton = {
        $0.addTarget(self, action: #selector(fbAuthButtonTapped), for: .touchUpInside)
        return $0
    }(CustomAuthButton(title: Texts.Auth.AuthButtons.facebook, state: .normal, image: Icons.Auth.fbAuth, isHidden: false))
    
    private lazy var appleLoginBtn: CustomAuthButton = {
        return $0
    }(CustomAuthButton(title: Texts.Auth.AuthButtons.apple, state: .normal, image: Icons.Auth.appleAuth, isHidden: false))
    
    private lazy var googleLoginBtn: CustomAuthButton = {
        $0.addTarget(self, action: #selector(googleAuthButtonTapped), for: .touchUpInside)

        return $0
    }(CustomAuthButton(title: Texts.Auth.AuthButtons.google, state: .normal, image: Icons.Auth.googleAuth, isHidden: false))
    
    private lazy var vkLoginBtn: CustomAuthButton = {
        $0.addTarget(self, action: #selector(vkAuthButtonTapped), for: .touchUpInside)
        return $0
    }(CustomAuthButton(title: Texts.Auth.AuthButtons.vkontakte, state: .normal, image: Icons.Auth.vkAuth, isHidden: false))
    
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
    
    private let regulationsLabel: UILabel = {
        $0.makeAttributedText(with: Texts.Auth.Regulations.upper, and: Texts.Auth.Regulations.bottom)
        $0.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var skipButton = UIButton.makeButton(title: Texts.Registration.addAvatar,
                                                           titleColor: Colors.mainBlue)
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = Colors.darkBlue
        
        skipButton.addTarget(self, action: #selector(handleSkipButton), for: .touchUpInside)
        
        addSubviews(logoImageView,titleLabel,regulationsLabel,
                    appleLoginBtn,googleLoginBtn,vkLoginBtn,fbLoginBtn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.15)
            $0.height.equalTo(logoImageView.snp.width)
            $0.centerY.equalToSuperview().multipliedBy(0.4)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(self.frame.size.height / 10)
            $0.centerX.equalToSuperview()
        }
        
        appleLoginBtn.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().offset(-40)
                $0.width.equalToSuperview().multipliedBy(0.87)
                $0.height.equalTo(48)
        }
        googleLoginBtn.snp.makeConstraints {
                $0.centerX.equalToSuperview()
            $0.top.equalTo(appleLoginBtn.snp.bottom).offset(12)
                $0.width.equalToSuperview().multipliedBy(0.87)
                $0.height.equalTo(48)
        }
        vkLoginBtn.snp.makeConstraints {
                $0.centerX.equalToSuperview()
            $0.top.equalTo(googleLoginBtn.snp.bottom).offset(12)
                $0.width.equalToSuperview().multipliedBy(0.87)
                $0.height.equalTo(48)
        }
        fbLoginBtn.snp.makeConstraints {
                $0.centerX.equalToSuperview()
            $0.top.equalTo(vkLoginBtn.snp.bottom).offset(12)
                $0.width.equalToSuperview().multipliedBy(0.87)
                $0.height.equalTo(48)
        }
        regulationsLabel.snp.makeConstraints {
            $0.top.equalTo(fbLoginBtn.snp.bottom).offset(16)
            $0.width.centerX.equalTo(fbLoginBtn)
            $0.height.equalTo(fbLoginBtn)
        }
    }
    
    //MARK: - Actions

    @objc private func handleSubmitButton() {
        let text = phoneNumberAddView.text
        delegate?.submitButtonTapped(with: text)
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
    @objc private func fbAuthButtonTapped() {
        delegate?.fbAuthClicked()
    }
    
    @objc private func vkAuthButtonTapped() {
        delegate?.vkAuthButtonClicked()
    }
    
    @objc private func googleAuthButtonTapped () {
        GIDSignIn.sharedInstance()?.signIn()
    }
}

//MARK: Actions

@objc private extension AuthView {
    
    func handleSkipButton() {
        delegate?.skipButtonClicked()
    }
    
    //MARK: - FaceBookDelegate Methods
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        delegate?.fbAuthPassed()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        return
    }
}

//MARK: - GoogleAuth Methods
extension AuthView: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
                if let error = error {
                    if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                      print("The user has not signed in before or they have since signed out.")
                    } else {
                      print("\(error.localizedDescription)")
                    }
                    return
                  }
                  // Perform any operations on signed in user here.
                  let userId = user.userID                  // For client-side use only!
                  let idToken = user.authentication.idToken // Safe to send to the server
                  let fullName = user.profile.name
                  let givenName = user.profile.givenName
                  let familyName = user.profile.familyName
                  let email = user.profile.email
        print (userId,idToken,email)
    }
    
    
}
