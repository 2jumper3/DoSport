//
//  SingInViewController.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

final class SingInViewController: UIViewController {
    
    private let viewModel: SignInViewModel
    
    init(viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupViewModelBindings()
    }
    
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
    
    private lazy var fbAuthButton = DSButtonWithIcon(
        img: Icons.Auth.fbAuth,
        txt: Texts.Auth.AuthButtons.facebook,
        isTextInCenter: true)
    
    private lazy var appleAuthButton = DSButtonWithIcon(
        img: Icons.Auth.appleAuth,
        txt: Texts.Auth.AuthButtons.apple,
        isTextInCenter: true)
    
    private lazy var googleAuthButton = DSButtonWithIcon(
        img: Icons.Auth.googleAuth,
        txt: Texts.Auth.AuthButtons.google,
        isTextInCenter: true)
    
    private lazy var vkAuthButton = DSButtonWithIcon(
        img: Icons.Auth.vkAuth,
        txt: Texts.Auth.AuthButtons.vkontakte,
        isTextInCenter: true)
    
    private let logoImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = Icons.Auth.logo
        return $0
    }(UIImageView())
    
    private let regulationsLabel: UILabel = {
        $0.makeAttributedText(with: Texts.Auth.Regulations.upper, and: Texts.Auth.Regulations.bottom)
        $0.font = UIFont.preferredFont(forTextStyle: .footnote)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private lazy var skipButton = UIButton.makeSimpleButton(title: Texts.Auth.skip,
                                                            titleColor: Colors.mainBlue)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

//MARK: Setup UI

private extension SingInViewController {
    
    func setupUI() {
        self.addSubviews()
        self.constratinViews()
        self.setupButtonTargets()
    }
    
    func addSubviews() {
        self.view.addSubviews(
            logoImageView,
            titleLabel,
            regulationsLabel,
            appleAuthButton,
            googleAuthButton,
            vkAuthButton,
            fbAuthButton,
            skipButton)
    }
    
    func constratinViews() {
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.15)
            $0.height.equalTo(logoImageView.snp.width)
            $0.centerY.equalToSuperview().multipliedBy(0.4)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(self.view.frame.size.height / 10)
            $0.centerX.equalToSuperview()
        }
        
        appleAuthButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-40)
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(48)
        }
        
        googleAuthButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(appleAuthButton.snp.bottom).offset(12)
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(48)
        }
        
        vkAuthButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(googleAuthButton.snp.bottom).offset(12)
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(48)
        }
        
        fbAuthButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(vkAuthButton.snp.bottom).offset(12)
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(48)
        }
        
        regulationsLabel.snp.makeConstraints {
            $0.top.equalTo(fbAuthButton.snp.bottom).offset(16)
            $0.width.centerX.equalTo(fbAuthButton)
            $0.height.equalTo(fbAuthButton)
        }
        
        skipButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaInsets.bottom).offset(-30)
        }
    }
    
    func setupButtonTargets() {
        self.skipButton.addTarget(self, action: #selector(handleSkipButton))
        self.appleAuthButton.addTarget(self, action: #selector(handleAppleAuthButton))
        self.googleAuthButton.addTarget(self, action: #selector(handleGoogleAuthButton))
        self.vkAuthButton.addTarget(self, action: #selector(handleVKAuthButton))
        self.fbAuthButton.addTarget(self, action: #selector(handleFBAuthButton))
    }
}

//MARK: Private API

private extension SingInViewController {
    
    func setupViewModelBindings() {
        viewModel.onDidSignUpWithSocialMedia = { /*[unowned self]*/ state in
            switch state {
            case .loading:
                break
            case .failed:
                break
            case .success:
                break
            }
        }
        
        viewModel.onDidSendSignUpDataToServer = { state in
            
        }
        
        viewModel.onDidLogin = { [unowned self] state in
            switch state {
            case .loading:
                break
            case .failed:
                break
            case .success:
                self.viewModel.goToFeedModuleRequest()
            }
        }
    }
}

//MARK: Actions

@objc private extension SingInViewController {
    
    func handleSkipButton() {
        //        coordinator?.goToMainTabBar()
        //        coordinator?.goToRegistrationModule()
        
        // will be replaced by social media auth
        viewModel.doLogin(
            with: .init(
                username: "admin",
                password: "admin"
            )
        )
    }
    
    func handleFBAuthButton() {
        viewModel.doSignUpWithSocialMedia(.facebook, viewController: self)
    }
    
    func handleVKAuthButton() {
        viewModel.doSignUpWithSocialMedia(.vkontakte, viewController: nil)
    }
    
    func handleGoogleAuthButton() {
        viewModel.doSignUpWithSocialMedia(.google, viewController: self)
    }
    
    func handleAppleAuthButton() {
        viewModel.doSignUpWithSocialMedia(.apple, viewController: nil)
    }
}
