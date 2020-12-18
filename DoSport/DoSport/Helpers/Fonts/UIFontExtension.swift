//
//  UIFontExtension.swift
//  DoSport
//
//  Created by Sergey on 18.12.2020.
//

import Foundation
import UIKit

extension UIFont {

    static func sfProNormal(size: CGFloat) -> UIFont {
        return UIFont(name: "SFProDisplay-Regular", size: size) ?? UIFont()
    }
}
