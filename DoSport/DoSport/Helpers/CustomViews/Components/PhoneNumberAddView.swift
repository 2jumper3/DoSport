//
//  PhoneNumberAddView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit
import SnapKit

protocol PhoneNumberAddViewDelegate: AnyObject {
    func textFieldTapped()
}

final class PhoneNumberAddView: UIView {
    
    weak var delegate: PhoneNumberAddViewDelegate?
    
    var text: String {
        return textField.text ?? ""
    }
    
    private lazy var button: UIButton = {
        $0.titleLabel?.font = Fonts.sfProRegular(size: 12)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle(("+7"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.titleLabel?.textAlignment = .center
        return $0
    }(UIButton(type: .system))
    
    private lazy var textField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.delegate = self
        $0.keyboardType = .numberPad
        $0.attributedPlaceholder = NSAttributedString(
            string: Texts.Auth.phoneNumberPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: Colors.dirtyBlue]
        )
        return $0
    }(UITextField())
    
    private let verticalBorderView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Colors.dirtyBlue
        return $0
    }(UIView())
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = Colors.dirtyBlue.cgColor
        translatesAutoresizingMaskIntoConstraints = false

        addSubviews(button, verticalBorderView, textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.7)
            $0.width.equalToSuperview().multipliedBy(0.15)
        }
        
        verticalBorderView.snp.makeConstraints {
            $0.left.equalTo(button.snp.right)
            $0.width.equalTo(1)
            $0.height.centerY.equalTo(button)
        }
        
        textField.snp.makeConstraints {
            $0.centerY.height.equalTo(button)
            $0.left.equalTo(verticalBorderView.snp.right).offset(12)
            $0.right.equalToSuperview().offset(-5)
        }
    }
}

//MARK: - Public Methods
 
extension PhoneNumberAddView {
    func bind(callingCode: String) {
        self.button.setTitle(callingCode, for: .normal)
        layoutIfNeeded()
    }
    
    func addButtonTarget(_ target: Any?, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func removeFirstResponder() {
        textField.resignFirstResponder()
    }
}

extension PhoneNumberAddView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(9)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(10)
        return true
    }
}
