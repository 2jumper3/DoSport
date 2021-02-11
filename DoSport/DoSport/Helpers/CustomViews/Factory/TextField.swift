//
//  UITextField.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 13/01/2021.
//

import UIKit

extension UITextField {
    
    static func makeCodeEntryTextField() -> UITextField {
        let textField = UITextField()
        textField.isUserInteractionEnabled = false
        textField.font = Fonts.sfProRegular(size: 32)
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.dirtyBlue.cgColor
        textField.layer.cornerRadius = 8
        return textField
    }
    
    static func makeTextFieldWith(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = Fonts.sfProRegular(size: 16)
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.dirtyBlue.cgColor
        textField.layer.cornerRadius = 8
        return textField
    }
}
