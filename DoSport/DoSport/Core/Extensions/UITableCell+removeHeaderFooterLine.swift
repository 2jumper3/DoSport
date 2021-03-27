//
//  UITableCell+removeHeaderFooterLine.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 27/02/2021.
//

import UIKit.UITableViewCell

extension UITableViewCell {
    
    /// To remove not needed default topmost and bottommost separators of Table View cell
    func removeSectionSeparators() {
        for subview in subviews {
            if subview != contentView && subview.frame.width == frame.width {
                subview.removeFromSuperview()
            }
        }
    }
}


