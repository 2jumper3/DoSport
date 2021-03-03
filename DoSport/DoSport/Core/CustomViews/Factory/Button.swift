//
//  Button.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 16/01/2021.
//

import UIKit.UIButton

extension UIButton {
    
    //  Creates simple, not styled button using 'title' and 'textColor' only
    
    static func makeButton(title: String, titleColor: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitleColor(titleColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = Fonts.sfProRegular(size: 16)
        button.titleLabel?.textAlignment = .center
        return button
    }
}
