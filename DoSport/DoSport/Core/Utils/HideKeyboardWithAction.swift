//
//  HideKeyboardWithAction.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 11/01/2021.
//

import UIKit.UIView

func hideKeyboard(for view: UIView, with action: () -> Swift.Void) {
    if view.isFirstResponder {
        view.resignFirstResponder()
        action()
    } else {
        action()
    }
}
