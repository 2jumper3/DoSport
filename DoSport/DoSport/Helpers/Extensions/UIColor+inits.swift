//
//  UIColor+inits.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/12/2020.
//

import UIKit.UIColor

public extension UIColor {
    convenience init(hex: UInt) {
        let red = (CGFloat((hex >> 16) & 0xff)) / CGFloat(0xff)
        let green = (CGFloat((hex >> 8) & 0xff)) / CGFloat(0xff)
        let blue = (CGFloat((hex >> 0) & 0xff)) / CGFloat(0xff)
        let alpha = hex > 0xffffff ? (CGFloat((hex >> 24) & 0xff)) / CGFloat(0xff) : 1

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init(hexString: String) {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        guard cString.count == 6 else {
            self.init(hex: 0xFF0000)
            return
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(hex: UInt(rgbValue))
    }

    convenience init(_ r: CGFloat, _ g: CGFloat? = nil, _ b: CGFloat? = nil, _ a: CGFloat = 1) {
        if let g = g, let b = b {
            self.init(red: r, green: g, blue: b, alpha: a)
        } else {
            self.init(red: r, green: r, blue: r, alpha: a)
        }
    }
}
