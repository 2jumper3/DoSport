//
//  FormTextFieldView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/01/2021.
//

import UIKit


enum FormTextFieldViewState { // FIXME able to combine this
    case normal, error
}

enum FormTextFieldViewType: Equatable { // FIXME able to combine this
    case userName, password, dob, custom(placeholder: String)
}

final class FormTextFieldView: UIView {
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    private var state: FormTextFieldViewState = .normal {
        didSet {
            handleDidSetState()
        }
    }
    
    //MARK: Outlets
    
    private let type: FormTextFieldViewType
    
    private lazy var textField = DSTextField(type: self.type)
    
    private lazy var errorLabel: UILabel = {
        if self.type == .userName {
            $0.text = Texts.Registration.userNameError
        }
        $0.textColor = Colors.textError
        $0.isHidden = true
        $0.font = Fonts.sfProRegular(size: 16)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    //MARK: Init
    
    init(type: FormTextFieldViewType) {
        self.type = type
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(textField, errorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.65)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(5)
            $0.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
    }
}

//MARK: Public API

extension FormTextFieldView {
    
    func bind(compilation: (FormTextFieldViewState) -> ()) {
        switch state {
        case .normal:
            self.state = .error
        case .error:
            self.state = .normal
        }
        compilation(self.state)
    }
    
    func removeTextFieldFirstResponder() {
        textField.resignFirstResponder()
    }
    
    func makeTextFieldFirstResponder() {
        textField.becomeFirstResponder()
    }
    
    func getTextField() -> UITextField {
        return self.textField
    }
}

//MARK: Private API

private extension FormTextFieldView {
    
    func handleDidSetState() {
        switch state {
        case .normal:
            errorLabel.isHidden = true
            textField.layer.borderColor = Colors.dirtyBlue.cgColor
        case .error:
            errorLabel.isHidden = false
            textField.layer.borderColor = Colors.textError.cgColor
        }
    }
}



