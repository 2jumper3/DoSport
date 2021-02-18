//
//  CodeLabelStackView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 13/01/2021.
//

import UIKit

protocol CodeLabelStackViewDelegate: class {
    func didEnterCode(_ code: String) 
}

final class CodeLabelStackView: UIView {
    
    weak var delegate: CodeLabelStackViewDelegate?
    
    var code: String = ""
    
    //MARK: Outlets
    
    private lazy var stackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .fill
        $0.spacing = 16
        return $0
    }(UIStackView())
    
    private var textFields: [Int: UITextField] = [:]
    
    //MARK: Init

    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        for i in 1...6 {
            let textField = UITextField.makeCodeEntryTextField()
            textField.tag = i
            self.textFields[i] = textField
            textField.addTarget(self, action: #selector(handleTextField))
            stackView.addArrangedSubview(textField)
        }
        
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

//MARK: Public API

extension CodeLabelStackView {
    
    func clearTextFields() {
        textFields.values.forEach { $0.text = "" }
    }
    
    func becomeTextFieldResponder() {
        guard let textFiedl = textFields[1] else { return }
        
        textFiedl.isUserInteractionEnabled = true
        textFiedl.becomeFirstResponder()
    }
}

//MARK: Actions

@objc private extension CodeLabelStackView {
    
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

//MARK: Private API

private extension CodeLabelStackView {
    
    func handleTextDidAdded(in textField: UITextField) {
        if let textFiedl1 = textFields[1], textField == textFiedl1, let textFiedl2 = textFields[2] {
            textFiedl2.isUserInteractionEnabled = true
            textFiedl2.text = " "
            textFiedl2.becomeFirstResponder()
            textFiedl1.isUserInteractionEnabled = false
        } else if let textFiedl2 = textFields[2], textField == textFiedl2, let textFiedl3 = textFields[3] {
            textFiedl3.isUserInteractionEnabled = true
            textFiedl3.text = " "
            textFiedl3.becomeFirstResponder()
            textFiedl2.isUserInteractionEnabled = false
        } else if let textFiedl3 = textFields[3], textField == textFiedl3, let textFiedl4 = textFields[4] {
            textFiedl4.isUserInteractionEnabled = true
            textFiedl4.text = " "
            textFiedl4.becomeFirstResponder()
            textFiedl3.isUserInteractionEnabled = false
        } else if let textFiedl4 = textFields[4], textField == textFiedl4, let textFiedl5 = textFields[5] {
            textFiedl5.isUserInteractionEnabled = true
            textFiedl5.text = " "
            textFiedl5.becomeFirstResponder()
            textFiedl4.isUserInteractionEnabled = false
        } else if let textFiedl5 = textFields[5], textField == textFiedl5, let textFiedl6 = textFields[6] {
            textFiedl6.isUserInteractionEnabled = true
            textFiedl6.text = " "
            textFiedl6.becomeFirstResponder()
            textFiedl5.isUserInteractionEnabled = false
        } else if let textFiedl6 = textFields[6], textField == textFiedl6 {
            textFiedl6.resignFirstResponder()
            textFiedl6.isUserInteractionEnabled = false
            delegate?.didEnterCode(code)
        }
    }
    
    func handleTextDidRemoved(in textField: UITextField) {
        if let textFiedl2 = textFields[2], textField == textFiedl2, let textFiedl1 = textFields[1] {
            textFiedl1.isUserInteractionEnabled = true
            textFiedl1.becomeFirstResponder()
            textFiedl1.text = ""
            textFiedl2.isUserInteractionEnabled = false
        } else if let textField3 = textFields[3], textField == textField3, let textFiedl2 = textFields[2] {
            textFiedl2.isUserInteractionEnabled = true
            textFiedl2.becomeFirstResponder()
            textFiedl2.text = " "
            textField3.isUserInteractionEnabled = false
        } else if let textFiedl4 = textFields[4], textField == textFiedl4, let textFiedl3 = textFields[3] {
            textFiedl3.isUserInteractionEnabled = true
            textFiedl3.becomeFirstResponder()
            textFiedl3.text = " "
            textFiedl4.isUserInteractionEnabled = false
        } else if let textFiedl5 = textFields[5], textField == textFiedl5, let textFiedl4 = textFields[4] {
            textFiedl4.isUserInteractionEnabled = true
            textFiedl4.becomeFirstResponder()
            textFiedl4.text = " "
            textFiedl5.isUserInteractionEnabled = false
        } else if let textFiedl6 = textFields[6], textField == textFiedl6, let textFiedl5 = textFields[5] {
            textFiedl5.isUserInteractionEnabled = true
            textFiedl5.becomeFirstResponder()
            textFiedl5.text = " "
            textFiedl6.isUserInteractionEnabled = false
        }
    }
}
