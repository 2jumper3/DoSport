//
//  DSKeychainConstants.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/03/2021.
//

import Foundation
import Security

/// Constants used by the library
struct DSKeychainConstants {
  /// Specifies a Keychain access group. Used for sharing Keychain items between apps.
  static var accessGroup: String { return toString(kSecAttrAccessGroup) }
  
  static var accessible: String { return toString(kSecAttrAccessible) }
  
  /// Used for specifying a String key when setting/getting a Keychain value.
  static var attrAccount: String { return toString(kSecAttrAccount) }

  /// Used for specifying synchronization of keychain items between devices.
  static var attrSynchronizable: String { return toString(kSecAttrSynchronizable) }
  
  /// An item class key used to construct a Keychain search dictionary.
  static var klass: String { return toString(kSecClass) }
  
  /// Specifies the number of values returned from the keychain. The library only supports single values.
  static var matchLimit: String { return toString(kSecMatchLimit) }
  
  /// A return data type used to get the data from the Keychain.
  static var returnData: String { return toString(kSecReturnData) }
  
  /// Used for specifying a value when setting a Keychain value.
  static var valueData: String { return toString(kSecValueData) }
    
  /// Used for returning a reference to the data from the keychain
  static var returnReference: String { return toString(kSecReturnPersistentRef) }
  
  /// A key whose value is a Boolean indicating whether or not to return item attributes
  static var returnAttributes : String { return toString(kSecReturnAttributes) }
    
  /// A value that corresponds to matching an unlimited number of items
  static var secMatchLimitAll : String { return toString(kSecMatchLimitAll) }
    
  static func toString(_ value: CFString) -> String {
    return value as String
  }
}
