//
//  DSMessageSendButton.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/02/2021.
//

import UIKit

final class DSMessageSendButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = Colors.lightBlue
        setImage(Icons.Event.messageSend, for: .normal)
        setTitleColor(.gray, for: .highlighted)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
