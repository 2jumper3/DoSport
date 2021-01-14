//
//  CodeLabelStackView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 13/01/2021.
//

import UIKit
import SnapKit

protocol CodeLabelStackViewDelegate: class {
    func didEnterCode(_ code: String) 
}

final class CodeLabelStackView: UIView {
    
    weak var delegate: CodeLabelStackViewDelegate?
    
    var code: String = ""
    
    private lazy var stackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .fill
        $0.spacing = 16
        return $0
    }(UIStackView())
    
    private lazy var textField1: UITextField = {
        $0.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        return $0
    }(UITextField.makeCodeEntryTextField(delegate: self))
    
    private lazy var textField2: UITextField = {
        $0.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        return $0
    }(UITextField.makeCodeEntryTextField(delegate: self))
    
    private lazy var textField3: UITextField = {
        $0.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        return $0
    }(UITextField.makeCodeEntryTextField(delegate: self))
    
    private lazy var textField4: UITextField = {
        $0.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        return $0
    }(UITextField.makeCodeEntryTextField(delegate: self))
    
    private lazy var textField5: UITextField = {
        $0.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        return $0
    }(UITextField.makeCodeEntryTextField(delegate: self))
    
    private lazy var textField6: UITextField = {
        $0.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        return $0
    }(UITextField.makeCodeEntryTextField(delegate: self))
    
    //MARK: - Init

    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubviews(
            textField1,
            textField2,
            textField3,
            textField4,
            textField5,
            textField6
        )
        addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//MARK: - Public methods

extension CodeLabelStackView {
    func bind() {
        textField1.isUserInteractionEnabled = true
        textField1.becomeFirstResponder()
    }
}

//MARK: - Actions

@objc extension CodeLabelStackView {
    func handleTextField(_ textField: UITextField) {
        if textField == textField1 && code.count == 0 {
            guard let text = textField.text else { return }
            code += text
            textField2.isUserInteractionEnabled = true
            textField2.becomeFirstResponder()
            textField1.isUserInteractionEnabled = false
        } else if textField == textField2 && code.count == 1 {
            guard let text = textField.text else { return }
            code += text
            textField3.isUserInteractionEnabled = true
            textField3.becomeFirstResponder()
            textField2.isUserInteractionEnabled = false
        } else if textField == textField3 && code.count == 2 {
            guard let text = textField.text else { return }
            code += text
            textField4.isUserInteractionEnabled = true
            textField4.becomeFirstResponder()
            textField3.isUserInteractionEnabled = false
        } else if textField == textField4 && code.count == 3 {
            guard let text = textField.text else { return }
            code += text
            textField5.isUserInteractionEnabled = true
            textField5.becomeFirstResponder()
            textField4.isUserInteractionEnabled = false
        } else if textField == textField5 && code.count == 4 {
            guard let text = textField.text else { return }
            code += text
            textField6.isUserInteractionEnabled = true
            textField6.becomeFirstResponder()
            textField5.isUserInteractionEnabled = false
        } else if textField == textField6 && code.count == 5 {
            guard let text = textField.text else { return }
            code += text
            textField6.resignFirstResponder()
            textField6.isUserInteractionEnabled = false
            delegate?.didEnterCode(code)
        }
    }
}

//MARK: - UITextFieldDelegate

extension CodeLabelStackView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        print(textField.text ?? "")
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(#function)
        print(textField.text ?? "")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        print(textField.text ?? "")
    }
}
