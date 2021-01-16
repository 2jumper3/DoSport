//
//  FormTextFieldView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 14/01/2021.
//

import UIKit
import SnapKit

final class FormTextFieldView: UIView {
    
    enum State {
        case normal, error
    }
    
    enum TextFieldType {
        case userName, password, dob
    }
    
    private var state: State = .normal {
        didSet {
            handleDidSetState()
        }
    }
    
    var text: String? {
        get { textField.text }
    }
    
    private let type: TextFieldType
    
    private(set) lazy var textField = DSTextField(type: self.type)
    
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
    
    //MARK: - Init
    
    init(type: TextFieldType) {
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

//MARK: - Public methods

extension FormTextFieldView {
    func bind(compilation: (State) -> ()) {
        switch state {
        case .normal:
            self.state = .error
        case .error:
            self.state = .normal
        }
        compilation(self.state)
    }
}

//MARK: - Private methods

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



