//
//  UISearchBar+textField.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 20/02/2021.
//

import UIKit.UISearchBar

extension UISearchBar {
    
    var compatibleSearchTextField: UITextField {
        guard #available(iOS 13.0, *) else { return legacySearchField }
        return self.searchTextField
    }

    private var legacySearchField: UITextField {
        if let textField = self.subviews.first?.subviews.last as? UITextField {
            // Xcode 11 previous environment
            return textField
        } else if let textField = self.value(forKey: "searchField") as? UITextField {
            // Xcode 11 run in iOS 13 previous devices
            return textField
        } else {
            return UITextField()
        }
    }
}
