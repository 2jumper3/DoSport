//
//  Fonts.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/12/2020.
//

import Foundation
import UIKit

public enum Fonts {
    static func sfProNormal(size: CGFloat) -> UIFont {
        let customFont = UIFont(name: "SFProDisplay-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        return customFont
    }
}
