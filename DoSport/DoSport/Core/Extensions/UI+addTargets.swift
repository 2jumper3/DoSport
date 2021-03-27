//
//  UI+addTargets.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 16/02/2021.
//

import UIKit

extension UIButton {
    
    func addTarget(_ target: Any?, action: Selector) {
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}

extension UITextField {
    
    func addTarget(_ target: Any?, action: Selector) {
        self.addTarget(target, action: action, for: .editingChanged)
    }
}
