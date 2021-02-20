//
//  DSMessageInputView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

protocol DSTextInputViewDelegate: class {
    func sendTextButtonClicked()
    func textFieldValueChaged(text: String?)
}

extension DSTextInputViewDelegate {
    
    /// in order to provide default implementation and do not force to implement in some classes when is not needed
    func textFieldValueChaged(text: String?) { }
}

final class DSMessageInputView: UIView {
    
    weak var delegate: DSTextInputViewDelegate?
    
    private let placeholderColor: UIColor
    
    //MARK: Outlets
    
    private lazy var messageSendButton = DSMessageSendButton()
    private lazy var textField = DSTextField(
        type: .custom(placeholder: Texts.Event.messages),
        placeholderColor: placeholderColor
    )
    
    //MARK: Init
    
    init(
        backgroundColor color: UIColor = Colors.darkBlue,
        borderColor bColor: UIColor = Colors.mainBlue,
        textColor tColor: UIColor = Colors.mainBlue,
        placeholderColor pColor: UIColor = Colors.mainBlue
    ) {
        self.placeholderColor = pColor
        super.init(frame: .zero)
        
        backgroundColor = color
        self.textField.layer.borderColor = bColor.cgColor
        self.textField.textColor = tColor
        
        messageSendButton.addTarget(self, action: #selector(handleSendTextButton))
        textField.addTarget(self, action: #selector(handleTextField))
        
        addSubviews(messageSendButton, textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.70)
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
    
    func handleTextField(_ textField: UITextField) {
        delegate?.textFieldValueChaged(text: textField.text)
    }
}
