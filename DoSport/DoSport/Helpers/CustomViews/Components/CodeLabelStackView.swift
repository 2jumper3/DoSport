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
    }(UITextField.makeCodeEntryTextField())
    
    private lazy var textField2: UITextField = {
        $0.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        return $0
    }(UITextField.makeCodeEntryTextField())
    
    private lazy var textField3: UITextField = {
        $0.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        return $0
    }(UITextField.makeCodeEntryTextField())
    
    private lazy var textField4: UITextField = {
        $0.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        return $0
    }(UITextField.makeCodeEntryTextField())
    
    private lazy var textField5: UITextField = {
        $0.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        return $0
    }(UITextField.makeCodeEntryTextField())
    
    private lazy var textField6: UITextField = {
        $0.addTarget(self, action: #selector(handleTextField), for: .editingChanged)
        return $0
    }(UITextField.makeCodeEntryTextField())
    
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
        
    }
    
    func becomeTextFieldResponder() {
        textField1.isUserInteractionEnabled = true
        textField1.becomeFirstResponder()
    }
}

//MARK: - Actions

@objc extension CodeLabelStackView {
    
    func handleTextField(_ textField: UITextField) {
        if var text = textField.text, text != "" {
            if text.first == " " {
                text.removeFirst()
            }
            code += text
            handleTextDidAdded(in: textField)
        } else {
            code.removeLast()
            handleTextDidRemoved(in: textField)
        }
    }
}

//MARK: - Private methods

private extension CodeLabelStackView {
    
    func handleTextDidAdded(in textField: UITextField) {
        if textField == textField1 {
            textField2.isUserInteractionEnabled = true
            textField2.text = " "
            textField2.becomeFirstResponder()
            textField1.isUserInteractionEnabled = false
        } else if textField == textField2 {
            textField3.isUserInteractionEnabled = true
            textField3.text = " "
            textField3.becomeFirstResponder()
            textField2.isUserInteractionEnabled = false
        } else if textField == textField3 {
            textField4.isUserInteractionEnabled = true
            textField4.text = " "
            textField4.becomeFirstResponder()
            textField3.isUserInteractionEnabled = false
        } else if textField == textField4 {
            textField5.isUserInteractionEnabled = true
            textField5.text = " "
            textField5.becomeFirstResponder()
            textField4.isUserInteractionEnabled = false
        } else if textField == textField5 {
            textField6.isUserInteractionEnabled = true
            textField6.text = " "
            textField6.becomeFirstResponder()
            textField5.isUserInteractionEnabled = false
        } else if textField == textField6 {
            textField6.resignFirstResponder()
            textField6.isUserInteractionEnabled = false
            delegate?.didEnterCode(code)
        }
    }
    
    func handleTextDidRemoved(in textField: UITextField) {
        if textField == textField2 {
            textField1.isUserInteractionEnabled = true
            textField1.becomeFirstResponder()
            textField1.text = ""
            textField2.isUserInteractionEnabled = false
        } else if textField == textField3 {
            textField2.isUserInteractionEnabled = true
            textField2.becomeFirstResponder()
            textField2.text = " "
            textField3.isUserInteractionEnabled = false
        } else if textField == textField4 {
            textField3.isUserInteractionEnabled = true
            textField3.becomeFirstResponder()
            textField3.text = " "
            textField4.isUserInteractionEnabled = false
        } else if textField == textField5 {
            textField4.isUserInteractionEnabled = true
            textField4.becomeFirstResponder()
            textField4.text = " "
            textField5.isUserInteractionEnabled = false
        }  else if textField == textField6 {
            textField5.isUserInteractionEnabled = true
            textField5.becomeFirstResponder()
            textField5.text = " "
            textField6.isUserInteractionEnabled = false
        }
    }
}
