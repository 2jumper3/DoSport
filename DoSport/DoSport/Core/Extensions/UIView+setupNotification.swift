//
//  UIView+setupNotification.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 16/03/2021.
//

import UIKit.UIView

extension UIView {
    
    func addObserver(selector: Selector, for name: Notification.Name, obj: Any? = nil) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: obj)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
