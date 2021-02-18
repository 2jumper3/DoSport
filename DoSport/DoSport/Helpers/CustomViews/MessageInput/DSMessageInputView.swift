//
//  DSMessageInputView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

protocol DSTextInputViewDelegate: class {
    func sendTextButtonClicked()
    
}

final class DSMessageInputView: UIView {
    
    weak var delegate: DSTextInputViewDelegate?
    
    //MARK: Outlets
    
    private let topSeparatorView = DSSeparatorView()
    private lazy var messageSendButton = DSMessageSendButton()
    private lazy var textField = UITextField.makeTextFieldWith(placeholder: Texts.Event.messages)
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = Colors.darkBlue
        
        messageSendButton.addTarget(self, action: #selector(handleSendTextButton))
        
        addSubviews(topSeparatorView, messageSendButton, textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        topSeparatorView.snp.makeConstraints {
            $0.centerX.width.top.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        textField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.75)
            $0.width.equalToSuperview().multipliedBy(0.79)
        }
        
        messageSendButton.snp.makeConstraints {
            $0.top.bottom.equalTo(textField)
            $0.right.equalToSuperview().offset(-10)
            $0.left.equalTo(textField.snp.right).offset(10)
        }
    }
}

//MARK: Public API

extension DSMessageInputView {
    
    func getInputText() -> String {
        guard let text = textField.text else { return "" }
        
        return text
    }
    
    func setInput(text: String) {
        self.textField.text = text
    }
    
    func makeTextFieldFirstResponder() {
        textField.becomeFirstResponder()
    }
    
    func removeTextFieldFirstResponder() {
        textField.resignFirstResponder()
    }
}

//MARK: Actions

@objc private extension DSMessageInputView {
    
    func handleSendTextButton() {
        delegate?.sendTextButtonClicked()
    }
}
