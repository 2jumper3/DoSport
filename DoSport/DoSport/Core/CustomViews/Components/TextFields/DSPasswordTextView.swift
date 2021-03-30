//
//  DSPasswordTextView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit

protocol DSPasswordTextViewDelegate: class {
    func visibilityControlButtonClicked()
    func textFieldDidEditing(_ text: String?)
}

enum TextVisibility {
    case normal, hidden
}

final class DSPasswordTextView: UIView {
    
    weak var delegate: DSPasswordTextViewDelegate?
    
    var text: String? {
        get { textField.text }
    }
    
    private var textVisibility: TextVisibility = .hidden {
        didSet {
            handleStateChagne()
        }
    }
    
    // MARK: Outlets
    
    private lazy var textField: DSTextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor.clear.cgColor
        $0.layer.borderWidth = 0
        return $0
    }(DSTextField(type: .password))
    
    private lazy var visibilityControlButton: UIButton = {
        let icon = textVisibility == .normal ? Icons.PasswordEntry.showedEye : Icons.PasswordEntry.hiddenEye
        $0.setImage(icon, for: .normal)
        $0.tintColor = Colors.mainBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))
    
    //MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        layer.borderColor = Colors.dirtyBlue.cgColor
        layer.cornerRadius = 8
        
        setupOutletTargets()
        
        addSubviews(textField, visibilityControlButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.centerY.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        visibilityControlButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-15)
            $0.centerY.height.equalToSuperview()
            $0.width.equalTo(visibilityControlButton.snp.width)
        }
    }
}

//MARK: Public API

extension DSPasswordTextView {
    
    func bind() {
        switch textVisibility {
        case .normal: textVisibility = .hidden
        case .hidden: textVisibility = .normal
        }
    }
    
    func getTextField() -> UITextField {
        return textField
    }
    
    func makeTextFieldFirstResponder() {
        textField.becomeFirstResponder()
    }
    
    func removeTextFieldFirstResponder() {
        textField.resignFirstResponder()
    }
}

//MARK: Private API

private extension DSPasswordTextView {
    
    func setupOutletTargets() {
        visibilityControlButton.addTarget(self, action: #selector(handleVisibilityControlButton))
        textField.addTarget(self, action: #selector(handleTextFieldEditing))
    }
    
    func handleStateChagne() {
        switch textVisibility {
        case .normal:
            textField.isSecureTextEntry = false
            visibilityControlButton.setImage(Icons.PasswordEntry.showedEye, for: .normal)
        case .hidden:
            textField.isSecureTextEntry = true
            visibilityControlButton.setImage(Icons.PasswordEntry.hiddenEye, for: .normal)
        }
        setNeedsDisplay()
    }
}

//MARK: Actions

@objc private extension DSPasswordTextView {
    
    func handleVisibilityControlButton() {
        delegate?.visibilityControlButtonClicked()
    }
    
    func handleTextFieldEditing(_ textField: UITextField) {
        delegate?.textFieldDidEditing(textField.text)
    }
}

