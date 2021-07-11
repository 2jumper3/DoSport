//
//  FeedbackView.swift
//  DoSport
//
//  Created by Dmitrii Diadiushkin on 31.05.2021.
//

import UIKit

final class FeedbackView: UIView {
    
    private lazy var avaImage: DSAvatartImageView = {
        let image = DSAvatartImageView()
        image.backgroundColor = .white
        return image
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = Texts.Registration.userName
        label.frame.size.height = 24
        label.frame.size.width = 54
        label.font = Fonts.sfProRegular(size: 16)
        label.textColor = Colors.lightBlue
        return label
    }()
    
    private lazy var feedBackTextField: UITextView = {
        let textField = UITextView()
        textField.backgroundColor = Colors.darkBlue
        textField.text = Texts.FeedBack.placeholder
        textField.font = Fonts.sfProRegular(size: 16)
        textField.textColor = Colors.lightBlue
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var ratingStackView: DSRatingStackView = {
        let stackView = DSRatingStackView()
        stackView.delegate = self
        return stackView
    }()
   
    private lazy var publishButton = DSCommonButton(title: Texts.FeedBack.publish, state: .disabled)
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        
        addSubviews(
            avaImage,
            userNameLabel,
            feedBackTextField,
            ratingStackView,
            publishButton
        )
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.addGestureRecognizer(hideKeyboardGesture)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var buttonsHeight: CGFloat = 48
        var buttonBottom: CGFloat = 15
        
        switch UIDevice.deviceSize {  // FIXME: костыль?
        case .iPhone_5_5S_5C_SE1, .iPhone_6_6S_7_8_SE2:
            buttonsHeight = 46
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini:
            buttonsHeight = 48
            buttonBottom += 15
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max:
            buttonsHeight = 49
            buttonBottom += 20
        }
        
        avaImage.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.width.equalTo(80)
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(avaImage)
            $0.top.equalTo(avaImage.snp.bottom).offset(12)
        }
        
        feedBackTextField.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(18)
            $0.right.equalToSuperview().offset(-14)
            $0.bottom.equalTo(ratingStackView.snp.top).offset(-12)
        }
        
        ratingStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(publishButton.snp.top).offset(-51)
        }
        
        publishButton.snp.makeConstraints {
            $0.height.equalTo(buttonsHeight)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
        
    }
}

extension FeedbackView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Texts.FeedBack.placeholder {
            textView.text = ""
            textView.textColor = .white
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            publishButton.bind(state: .disabled)
        } else {
            checkForButtonOn()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = Texts.FeedBack.placeholder
            textView.textColor = Colors.lightBlue
        }
    }
}

extension FeedbackView: DSRatingStackViewDelegate {
    func ratingViewTapped() {
        checkForButtonOn()
    }
    
}

extension FeedbackView {
    @objc func hideKeyboard() {
        self.endEditing(true)
    }
    
    private func checkForButtonOn() {
        if (feedBackTextField.text != Texts.FeedBack.placeholder) && (ratingStackView.getState() == .rated) {
            publishButton.bind(state: .normal)
        } else {
            publishButton.bind(state: .disabled)
        }
    }
}
