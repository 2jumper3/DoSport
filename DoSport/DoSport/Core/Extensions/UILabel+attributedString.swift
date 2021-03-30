//
//  UILabel+attributedString.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/01/2021.
//

import UIKit

extension UILabel {
    
    func makeAttributedText(
        with text1: String,
        and text2: String,
        text1Color color1: UIColor = Colors.dirtyBlue,
        text2Color color2: UIColor = Colors.mainBlue
    ) {
        let upperTextAttrs: [NSAttributedString.Key: Any] = [.foregroundColor: color1]
        let bottomTextAttrs: [NSAttributedString.Key: Any] = [.foregroundColor: color2]
        
        let text = NSMutableAttributedString(
            string: text1,
            attributes: upperTextAttrs
        )
        let bottomText = NSMutableAttributedString(
            string: text2,
            attributes: bottomTextAttrs
        )
            
        text.append(bottomText)
        self.attributedText = text
    }
}
