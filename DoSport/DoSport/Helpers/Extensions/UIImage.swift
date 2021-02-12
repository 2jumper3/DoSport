//
//  UIImage.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import UIKit

extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
