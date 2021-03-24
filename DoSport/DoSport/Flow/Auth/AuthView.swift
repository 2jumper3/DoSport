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

protocol AuthViewDelegate: class {
    func skipButtonTapped()
    func fbAuthPassed()
    func fbAuthClicked()
    func vkAuthButtonClicked()
}

class AuthView: UIView, LoginButtonDelegate {

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

@objc extension AuthView {
    
    func handleSkipButton() {
        self.delegate?.skipButtonTapped()
    }
    
    func loginButton(
        _ loginButton: FBLoginButton,
        didCompleteWith result: LoginManagerLoginResult?,
        error: Error?
    ) {
        delegate?.fbAuthPassed()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        return
    }
}

//MARK: - GIDSignInDelegate -

extension AuthView: GIDSignInDelegate {
    
    func sign(
        _ signIn: GIDSignIn!,
        didSignInFor user: GIDGoogleUser!,
        withError error: Error!
    ) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        let _ = user.userID
        let _ = user.authentication.idToken
        let _ = user.profile.name
        let _ = user.profile.givenName
        let _ = user.profile.familyName
        let _ = user.profile.email
//        print (userId,idToken,email)
    }
}
