//
//  Buttons.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/03/2021.
//

import UIKit.UIButton

//MARK: - Buttons without state -

extension UIButton {
    ///  Creates `Simple` button with styled text only
    ///
    /// - Parameters:
    ///     - title: text of button
    ///     - titleColor: text color of button
    /// - Returns: object of UIButton with provided params
    static func makeSimpleButton(title: String, titleColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(titleColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = Fonts.sfProRegular(size: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }
    
    /// Creates button with icon to use as navBarButtonItem.
    ///
    ///  - Parameters:
    ///     - icon: UIImage used as button icon.
    /// - Returns: object of styled UIButton with icon.
    static func makeBarButton(with icon: UIImage? = Icons.CountryList.backButton) -> UIButton {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 20, y: 0, width: 40, height: 40)
        button.setImage(icon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleToFill
        return button
    }
    
    /// Creates button used DSMessageInputView as `send message` button.
    ///
    /// - Returns: object of styled UIButton.
    static func makeSendMessageButton() -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = Colors.lightBlue
        button.setImage(Icons.Event.messageSend, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

//MARK: - Buttons with state -

// API for creating`Checkbox` button and handling its state
extension UIButton {
    
    /// Creates checkbox button with icon.
    ///
    /// - Returns: object of styled UIButton.
    static func makeCheckboxButton() -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.dirtyBlue.cgColor
        button.backgroundColor = Colors.darkBlue
        button.setTitleColor(.gray, for: .highlighted)
        button.setImage(nil, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
        
    enum CheckboxButtonState {
        case selected, notSelected
    }
    
    var checkboxButtonState: CheckboxButtonState {
        get {
            return .notSelected
        }
        set {
            
        }
    }
    
    func bindCheckboxButtonState() {
        switch self.checkboxButtonState {
        case .selected: checkboxButtonState = .notSelected
        case .notSelected: checkboxButtonState = .selected
        }
        
        self.handleCheckboxButtonStateChange()
    }
    
    func getCheckboxButtonState() -> CheckboxButtonState {
        return checkboxButtonState
    }

    func handleCheckboxButtonStateChange() {
        switch checkboxButtonState {
        case .selected:
            UIViewPropertyAnimator(duration: 0.1, curve: .linear) { [self] in
                layer.borderColor = Colors.lightBlue.cgColor
                backgroundColor = Colors.lightBlue
                setImage(Icons.EventCreate.checkMark, for: .normal)
            }.startAnimation()
            
        case .notSelected:
            UIViewPropertyAnimator(duration: 0.1, curve: .linear) { [self] in
                layer.borderColor = Colors.dirtyBlue.cgColor
                backgroundColor = Colors.darkBlue
                setImage(nil, for: .normal)
            }.startAnimation()
        }
    }
}

// API for creating `Gender` selection button and handling its state
extension UIButton {
    
    /// Creates button that is used as user's `gender` selection button.
    ///
    /// - Parameters:
    ///     - title: titleLabel of button. It is either male/female
    /// - Returns: object of styled UIButton.
    static func makeGenderButton(with title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = Colors.dirtyBlue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = Fonts.sfProRegular(size: 16)
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        return button
    }
        
    enum GenderButtonState {
        case notSelected, selected
    }
    
    func bindGenderButtonState(state: GenderButtonState) {
        switch state {
        case .notSelected:
            backgroundColor = Colors.darkBlue
        case .selected:
            backgroundColor = Colors.lightBlue
        }
    }
}
