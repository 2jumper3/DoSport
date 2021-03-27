//
//  UIView+addSubviews.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 23/12/2020.
//

import UIKit.UIView

extension UIView {
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(self.addSubview)
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
}
