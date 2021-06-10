//
//  UIStackView+addArrangedSubviews.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 13/01/2021.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach(self.addArrangedSubview)
    }
    
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach(self.addArrangedSubview)
    }
}

