//
//  CodeEntryView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/01/2021.
//

import UIKit
import SnapKit

protocol CodeEntryViewDelegate: class {
    func didTapCodeResentButton()
    func didTapGoBackButton()
}

final class CodeEntryView: UIView {
    
    weak var delegate: CodeEntryViewDelegate?
    
    private lazy var goBackButton: DSBarBackButton = {
        $0.addTarget(self, action: #selector(handleGoBackButton), for: .touchUpInside)
        return $0
    }(DSBarBackButton())

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
    
    private let confirmationLabel: UILabel = {
        $0.text = Texts.CodeEntry.confirmation
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var codeLabelsStackView = CodeLabelStackView()
    
    private let codeSentToNumberLabel: UILabel = {
        $0.text = Texts.CodeEntry.codeSentToNumber
        $0.font = Fonts.sfProRegular(size: 14)
        $0.textAlignment = .center
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var codeResendButton: UIButton = {
        $0.setTitle(Texts.CodeEntry.codeResend, for: .normal)
        $0.setTitleColor(Colors.mainBlue, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = Fonts.sfProRegular(size: 16)
        $0.addTarget(self, action: #selector(handleCodeResendButton), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        
        addSubviews(
            goBackButton,
            logoImageView,
            titleLabel,
            confirmationLabel,
            codeLabelsStackView,
            codeSentToNumberLabel,
            codeResendButton
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        goBackButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaInsets.top).offset(40)
            $0.left.equalToSuperview().offset(17)
            $0.width.equalTo(10)
            $0.height.equalTo(18)
        }
        
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.15)
            $0.height.equalTo(logoImageView.snp.width)
            $0.bottom.equalTo(titleLabel.snp.top).offset(-66)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(confirmationLabel.snp.top).offset(-24)
            $0.centerX.equalToSuperview()
        }
        
        confirmationLabel.snp.makeConstraints {
            $0.bottom.equalTo(codeLabelsStackView.snp.top).offset(-12)
            $0.width.centerX.equalTo(codeLabelsStackView)
            $0.height.equalTo(17)
        }
        
        codeLabelsStackView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
            $0.height.equalTo(50)
        }
        
        codeSentToNumberLabel.snp.makeConstraints {
            $0.top.equalTo(codeLabelsStackView.snp.bottom).offset(16)
            $0.centerX.width.equalTo(codeLabelsStackView)
            $0.height.equalTo(17)
        }
        
        codeResendButton.snp.makeConstraints {
            $0.top.equalTo(codeSentToNumberLabel.snp.bottom).offset(24)
            $0.width.centerX.equalTo(codeLabelsStackView)
            $0.height.equalTo(24)
        }
    }
}

//MARK: - Public methods

extension CodeEntryView {
    func bind() {
        codeLabelsStackView.bind()
    }
}
 
//MARK: - Actions

@objc extension CodeEntryView {
    func handleCodeResendButton() {
        delegate?.didTapCodeResentButton()
    }
    
    func handleGoBackButton() {
        delegate?.didTapGoBackButton()
    }
}
