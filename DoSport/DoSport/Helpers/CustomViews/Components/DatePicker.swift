//
//  DatePicker.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 16/01/2021.
//

import UIKit

final class DSDatePicker: UIDatePicker {
    
    var onDoneButtonTap: (() -> Swift.Void)?
    
    private var toolBar: UIToolbar?

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
        
        self.toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 44))
        self.toolBar?.isTranslucent = false
        self.toolBar?.barTintColor = Colors.darkBlue_02
        
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

//MARK: - Public methods

extension DSDatePicker {
    func setTextField(_ textField: UITextField) {
        textField.inputView = self
        textField.inputAccessoryView = self.toolBar
    }
}

//MARK: - Actions

@objc
private extension DSDatePicker {
    func handleDoneButton() {
        onDoneButtonTap?()
    }
}
