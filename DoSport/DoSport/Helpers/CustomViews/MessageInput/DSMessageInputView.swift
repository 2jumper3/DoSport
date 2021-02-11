//
//  DSMessageInputView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit
import SnapKit

final class DSMessageInputView: UIView {
    
    private let topSeparatorView = DSSeparatorView()
    private(set) lazy var messageSendButton = DSMessageSendButton()
    private(set) lazy var textField = UITextField.makeTextFieldWith(placeholder: Texts.Event.messages)
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
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
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalToSuperview().multipliedBy(0.79)
        }
        
        messageSendButton.snp.makeConstraints {
            $0.top.bottom.equalTo(textField)
            $0.right.equalToSuperview().offset(-10)
            $0.left.equalTo(textField.snp.right).offset(10)
        }
    }
}
