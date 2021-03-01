//
//  UserReportMessageView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 28/02/2021.
//

import UIKit

protocol UserReportMessageViewDelegate: class {
    func sendButtonClicked()
}
    
final class UserReportMessageView: UIView {
    
    struct ViewData {
        let avatar: UIImage?
        let name: String?
    }
    
    weak var delegate: UserReportMessageViewDelegate?
    
    private let tabBarHeight = UIDevice.getDeviceRelatedTabBarHeight()
    
    //MARK: Outlets
    
    private let avatarImageView = DSAvatartImageView(image: Icons.Common.defaultAvatar, borderColor: Colors.dirtyBlue)
    
    private let userNameLabel: UILabel = {
        $0.textColor = Colors.mainBlue
        $0.text = Texts.Common.userName
        $0.font = Fonts.sfProRegular(size: 16)
        return $0
    }(UILabel())

    private let reportTextView: UITextView = {
        $0.textColor = .white
        $0.textAlignment = .justified
        $0.backgroundColor = .red
        $0.font = Fonts.sfProRegular(size: 16)
        $0.text = Texts.Common.reportAProblem + "..." /// default placeholder immitating text
        return $0
    }(UITextView())

    private lazy var sendButton = CommonButton(title: Texts.Common.send, state: .disabled)

    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        
        sendButton.addTarget(self, action: #selector(handleSendButton))
        reportTextView.delegate = self
        
        addSubviews(avatarImageView, userNameLabel, reportTextView, sendButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var avatarSize: CGFloat = 85
        var buttonHeight: CGFloat = 48
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2:
            avatarSize = 75
            buttonHeight = 44
        default: break
        }
        
        avatarImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaInsets.top).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(avatarSize)
            $0.height.equalTo(avatarImageView.snp.width)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        reportTextView.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        
        sendButton.snp.makeConstraints {
            $0.top.equalTo(reportTextView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.87)
            $0.height.equalTo(buttonHeight)
        }
    }
}

//MARK: Public API

extension UserReportMessageView {
 
    func bind(with data: UserReportMessageView.ViewData) {
        avatarImageView.image = data.avatar
        userNameLabel.text = data.name
    }
}

//MARK: Actions

@objc private extension UserReportMessageView {
    
    func handleSendButton() {
        reportTextView.resignFirstResponder()
    }
}

//MARK: - UITextViewDelegate -

extension UserReportMessageView: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.text = Texts.Common.reportAProblem
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        
        if text != Texts.Common.reportAProblem, !text.isEmpty {
            sendButton.bind(state: .normal)
        } else if text.isEmpty, text == "" {
            sendButton.bind(state: .disabled)
        }
    }
}
