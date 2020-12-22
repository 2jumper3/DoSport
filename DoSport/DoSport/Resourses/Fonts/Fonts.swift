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
        guard let customFont = UIFont(name: "SFProDisplay-Regular", size: size) else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """)
        }
        return customFont
    }
}
