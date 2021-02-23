//
//  DSTextField.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/01/2021.
//

import UIKit

final class DSTextField: UITextField {

    private let padding = UIEdgeInsets(top: 13, left: 17, bottom: 13, right: 0)
    
    init(type: FormTextFieldView.TextFieldType) {
        super.init(frame: .zero)
        
        var placeholderText: String = ""
        switch type {
        case .userName:
            placeholderText = Texts.Registration.userName
        case .password:
            placeholderText = Texts.Registration.password
            isSecureTextEntry = true
        case .dob:
            placeholderText = Texts.Registration.dob
        }
        font = Fonts.sfProRegular(size: 16)
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .left
        textColor = .white
        layer.borderWidth = 1
        layer.borderColor = Colors.dirtyBlue.cgColor
        layer.cornerRadius = 8
        attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.dirtyBlue]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
