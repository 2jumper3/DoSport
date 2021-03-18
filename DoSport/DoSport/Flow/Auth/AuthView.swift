//
//  AuthView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/12/2020.
//

import UIKit

protocol AuthViewDelegate: AnyObject {
    func skipButtonClicked()
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
        
        addSubviews(logoImageView,titleLabel,descriptionLabel,regulationsLabel,skipButton)
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
            $0.bottom.equalTo(titleLabel.snp.top).offset(-67)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(descriptionLabel.snp.top).offset(-24)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(skipButton.snp.top).offset(-12)
            $0.height.equalTo(skipButton.snp.height).multipliedBy(0.7)
            $0.width.centerX.equalTo(skipButton)
        }
        
        skipButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-40)
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(48)
        }
        
        regulationsLabel.snp.makeConstraints {
            $0.top.equalTo(skipButton.snp.bottom).offset(16)
            $0.width.centerX.equalTo(skipButton)
            $0.height.equalTo(descriptionLabel)
        }
    }
}

//MARK: Actions

@objc private extension AuthView {
    
    func handleSkipButton() {
        delegate?.skipButtonClicked()
    }
}
