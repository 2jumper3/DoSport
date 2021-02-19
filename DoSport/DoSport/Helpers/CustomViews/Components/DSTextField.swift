//
//  DSTextField.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/01/2021.
//

import UIKit

enum DSTextFieldState {
    case enable, disabled
}

final class DSTextField: UITextField {
    
    private var textFieldState: DSTextFieldState = .enable {
        didSet {
            handleStateChange()
        }
    }

    private let padding = UIEdgeInsets(top: 13, left: 17, bottom: 13, right: 0)
    
    //MARK: Init
    
    init(type: FormTextFieldViewType = .dob, placeholderColor: UIColor = Colors.mainBlue) {
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
        case .custom(let placeholder):
            placeholderText = placeholder
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
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Padding set
    
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

//MARK: Public API

extension DSTextField {
    
    func bind(state: DSTextFieldState) {
        textFieldState = state
    }
    
    func setPlaceholderColor(_ color: UIColor, for text: String) {
//        attributedPlaceholder = NSAttributedString(
//            string: text,
//            attributes: [NSAttributedString.Key.foregroundColor: color]
//        )
    }
}

//MARK: Private API

private extension DSTextField {
    
    func handleStateChange() {
        switch textFieldState {
        case .disabled:
            UIView.animate(withDuration: 0.3) { self.textColor = Colors.dirtyBlue }
        case .enable:
            UIView.animate(withDuration: 0.3) { self.textColor = .white }
        }
    }
}
