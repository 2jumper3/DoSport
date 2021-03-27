//
//  DSKeychainAccessOptions.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/03/2021.
//

import Foundation
import Security

enum DSKeychainAccessOptions {
  
  /// The data in the keychain item can be accessed only while the device is unlocked by the user.
  case accessibleWhenUnlocked
  
  /// The data in the keychain item can be accessed only while the device is unlocked by the user.
  case accessibleWhenUnlockedThisDeviceOnly
  
  ///The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
  case accessibleAfterFirstUnlock
  
  
  ///The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
  case accessibleAfterFirstUnlockThisDeviceOnly

  ///The data in the keychain can only be accessed when the device is unlocked. Only available if a passcode is set on the device.
  case accessibleWhenPasscodeSetThisDeviceOnly
  
  static var defaultOption: DSKeychainAccessOptions {
    return .accessibleWhenUnlocked
  }
  
  var value: String {
    switch self {
    case .accessibleWhenUnlocked:
      return toString(kSecAttrAccessibleWhenUnlocked)
      
    case .accessibleWhenUnlockedThisDeviceOnly:
      return toString(kSecAttrAccessibleWhenUnlockedThisDeviceOnly)
      
    case .accessibleAfterFirstUnlock:
      return toString(kSecAttrAccessibleAfterFirstUnlock)
      
    case .accessibleAfterFirstUnlockThisDeviceOnly:
      return toString(kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly)
      
    case .accessibleWhenPasscodeSetThisDeviceOnly:
      return toString(kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly)
    }
  }
  
  func toString(_ value: CFString) -> String {
    return DSKeychainConstants.toString(value)
  }
}
