//
//  UIDevide+getDeviceModel.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 13/02/2021.
//

import UIKit.UIDevice

extension UIDevice {

    enum DSDeviceType {
        case iPhone_5_5S_5C_SE1
        case iPhone_6_6S_7_8_SE2
        case iPhone_6_6S_7_8_PLUS
        case iPhone_X_XS_12mini
        case iPhone_XR_11
        case iPhone_XS_11Pro_Max
        case iPhone_12_Pro
        case iPhone_12_Pro_Max
        
        /// Remove later. Need to fix in almost every screen
        case big
        case small
    }
    
    static var hasBang: Bool {
        switch UIDevice.deviceSize {
        case .iPhone_X_XS_12mini, .iPhone_XR_11, .iPhone_XS_11Pro_Max, .iPhone_12_Pro, .iPhone_12_Pro_Max:
            return false
        default:
            return true
        }
    }
    
    static var deviceSize: DSDeviceType {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136: return .iPhone_5_5S_5C_SE1
            case 1334: return .iPhone_6_6S_7_8_SE2
            case 1920, 2208: return .iPhone_6_6S_7_8_PLUS
            case 2436: return .iPhone_X_XS_12mini
            case 2532: return .iPhone_12_Pro
            case 2688: return .iPhone_XS_11Pro_Max
            case 2778: return .iPhone_12_Pro_Max
            case 1792: return .iPhone_XR_11
            default:
                assertionFailure("Unknown phone device detected!", file: #function)
                return .iPhone_6_6S_7_8_SE2
            }
        }
        
        return .iPhone_6_6S_7_8_SE2
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
}

