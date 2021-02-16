//
//  TextViewCell.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

final class TextViewCell: UITableViewCell {

    // MARK: Outlets
    
    private let textView: UITextView = {
        $0.textColor = .white
        $0.backgroundColor = .clear
        $0.textAlignment = .justified
        $0.font = Fonts.sfProRegular(size: 18)
        $0.text = Texts.EventCreate.placeholder
        return $0
    }(UITextView())
    
    private lazy var keyboardDoneButton: UIBarButtonItem = {
        return UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(handleDoneButton)
        )
    }()
    
    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupKeyboardDoneButton()
        
        contentView.addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textView.snp.makeConstraints{ $0.edges.equalToSuperview().inset(20) }
    }
}

//MARK: Private API

private extension TextViewCell {
    
    func setupKeyboardDoneButton() {
        let doneToolbar: UIToolbar = UIToolbar(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: 50
            )
        )
        
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let items = [flexSpace, keyboardDoneButton]
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textView.inputAccessoryView = doneToolbar
    }
}

//MARK: Actions

@objc private extension TextViewCell {
    
    func handleDoneButton() {
        textView.resignFirstResponder()
    }
}

