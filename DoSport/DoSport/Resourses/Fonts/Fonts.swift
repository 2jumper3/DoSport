//
//  Fonts.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/12/2020.
//

import Foundation
import UIKit

public enum Fonts {
    static func sfProRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "SFProDisplay-Regular", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
