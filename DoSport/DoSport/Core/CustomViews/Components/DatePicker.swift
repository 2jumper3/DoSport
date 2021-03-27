//
//  DatePicker.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 16/01/2021.
//

import UIKit

protocol DSDatePickerDelegate: class {
    func doneButtonClicked()
}

/// This class describes custom datePicker control with additional functionality.
///
/// Mainly this class implements some logic to move out from View or ViewController:
/// - datePicker setup into the textField
/// - `done` button setup into the textField that showing datePicker.
/// - handling `done` button and calling delegate.
final class DSDatePicker: UIDatePicker {
    
    weak var delegate: DSDatePickerDelegate?
    
    private var toolBar: UIToolbar?
    
    //MARK: Init

    init() {
        super.init(frame: .zero)
        
        datePickerMode = .date
        backgroundColor = Colors.darkBlue
        setValue(UIColor.white, forKey: "textColor")
        
        let doneButton = UIBarButtonItem(
            title: "Готово",
            style: .done,
            target: self,
            action: #selector(handleDoneButton)
        )
        
        toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 44))
        toolBar?.isTranslucent = false
        toolBar?.barTintColor = Colors.darkBlue_02
        
        let barButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil, action: nil
        )
        
        self.toolBar?.setItems([barButtonItem ,doneButton], animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Public API

extension DSDatePicker {
    
    func setTextField(_ textField: UITextField) {
        textField.inputView = self
        textField.inputAccessoryView = self.toolBar
    }
}

//MARK: Actions

@objc private extension DSDatePicker {
    
    func handleDoneButton() {
        delegate?.doneButtonClicked()
    }
}
