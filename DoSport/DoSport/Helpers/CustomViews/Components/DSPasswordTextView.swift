//
//  DSPasswordTextView.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 17/01/2021.
//

import UIKit
import SnapKit

final class DSPasswordTextView: UIView {
    
    enum State {
        case normal, hidden
    }
    
    private var textViewState: State = .hidden {
        didSet {
            handleStateChagne()
        }
    }
    
    private(set) lazy var textField = DSTextField(type: .password)
    
    private lazy var hideShowButton: UIButton = {
        let icon: UIImage = textViewState == .normal ? Icons.PasswordEntry.showedEye : Icons.PasswordEntry.hiddenEye
        $0.setImage(icon, for: .normal)
        $0.tintColor = Colors.mainBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))
    
    //MARK: - Init
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        layer.borderColor = Colors.dirtyBlue.cgColor
        layer.cornerRadius = 8
        
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 0
        
        addSubviews(textField, hideShowButton)
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
        
        hideShowButton.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-15)
            $0.centerY.height.equalToSuperview()
            $0.width.equalTo(hideShowButton.snp.width)
        }
    }
}

//MARK: - Public methods

extension DSPasswordTextView {
    func bind() {
        switch textViewState {
        case .normal:
            self.textViewState = .hidden
        case .hidden:
            self.textViewState = .normal
        }
    }
    
    func addButtonTarget(target: Any?, action: Selector) {
        hideShowButton.addTarget(target, action: action, for: .touchUpInside)
    }
}

//MARK: - Private methods

extension DSPasswordTextView {
    func handleStateChagne() {
        switch textViewState {
        case .normal:
            textField.isSecureTextEntry = false
            hideShowButton.setImage(Icons.PasswordEntry.showedEye, for: .normal)
        case .hidden:
            textField.isSecureTextEntry = true
            hideShowButton.setImage(Icons.PasswordEntry.hiddenEye, for: .normal)
        }
        layoutIfNeeded()
    }
}

