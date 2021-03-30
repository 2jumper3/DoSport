//
//  Fonts.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 18/12/2020.
//

import UIKit

public enum Fonts {
    static func sfProRegular( size: CGFloat) -> UIFont {
        var localSize = size
        switch UIDevice.deviceSize {
        case .iPhone_5_5S_5C_SE1: localSize -= 1
        case .iPhone_6_6S_7_8_SE2: break
        case .iPhone_6_6S_7_8_PLUS, .iPhone_X_XS_12mini: localSize += 1
        case .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max: localSize += 2
        }
        return UIFont(name: "SFProDisplay-Regular", size: localSize) ?? UIFont.systemFont(ofSize: localSize)
    }
}
