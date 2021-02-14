//
//  UIDevide+getDeviceModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 13/02/2021.
//

import UIKit.UIDevice

extension UIDevice { // костыль.. ?
    
    enum DSDeviceSize {
        case big // "iPhone X/XS/11 Pro""iPhone XS Max/11 Pro Max""iPhone XR/ 11 " = 49
        case small // "iPhone 5 or 5S or 5C" "iPhone 6/6S/7/8" "iPhone 6+/6S+/7+/8+" = 83
    }
    
    static var deviceSize: DSDeviceSize {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136, 1334, 1920, 2208: return .small
            case 2436, 2688, 1792: return .big
            default: break
            }
        }
        
        return .small
    }
    
    static func getDeviceRelatedTabBarHeight() -> Int {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136, 1334, 1920, 2208: return 49
            case 2436, 2688, 1792: return 83
            default: break
            }
        }
        
        return 0
    }
    
    static func getViewHeight() -> CGFloat {
        let deviceHeight: CGFloat = UIScreen.main.bounds.height
        let tabBarHeight: CGFloat = CGFloat(UIDevice.getDeviceRelatedTabBarHeight())
        let navBarHeight: CGFloat = 44.0
        let statusBarHeight: CGFloat
        
        switch deviceSize {
        case .big: statusBarHeight = 44.0
        case .small: statusBarHeight = 20.0
        }
        
        let viewHeight = deviceHeight - navBarHeight - tabBarHeight - statusBarHeight
        
        return viewHeight
    }
}

