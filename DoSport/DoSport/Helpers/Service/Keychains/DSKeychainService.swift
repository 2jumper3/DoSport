//
//  DSKeychainService.swift
//  DoSport
//
//  Created by Komolbek Ibragimov on 22/03/2021.
//

import Foundation
import Security

final class DSKeychainService {
    
    var lastQueryParameters: [String: Any]? // Used by the unit tests
    
    /// Contains result code from the last operation. Value is noErr (0) for a successful result.
    var lastResultCode: OSStatus = noErr
    
    var keyPrefix = ""
    
    var accessGroup: String?
    
    var synchronizable: Bool = false
    
    private let lock = NSLock()
    
    init() { }
    
    init(keyPrefix: String) {
        self.keyPrefix = keyPrefix
    }
    
    /// Stores the text value in the keychain item under the given key
    @discardableResult
    func set(
        _ value: String,
        forKey key: String,
        withAccess access: DSKeychainAccessOptions? = nil
    ) -> Bool {
        
        if let value = value.data(using: String.Encoding.utf8) {
            return set(value, forKey: key, withAccess: access)
        }
        
        return false
    }
    
    /// Stores the data in the keychain item under the given key
    @discardableResult
    func set(
        _ value: Data,
        forKey key: String,
        withAccess access: DSKeychainAccessOptions? = nil
    ) -> Bool {
        
        lock.lock()
        defer { lock.unlock() }
        
        let accessible = access?.value ?? DSKeychainAccessOptions.defaultOption.value
        
        let prefixedKey = keyWithPrefix(key)
        
        var query: [String : Any] = [
            DSKeychainConstants.klass       : kSecClassGenericPassword,
            DSKeychainConstants.attrAccount : prefixedKey,
            DSKeychainConstants.valueData   : value,
            DSKeychainConstants.accessible  : accessible
        ]
        
        query = addSynchronizableIfRequired(query, addingItems: true)
        lastQueryParameters = query
        
        lastResultCode = SecItemAdd(query as CFDictionary, nil)
        
        return lastResultCode == noErr
    }
    
    /// Stores the boolean value in the keychain item under the given key
    @discardableResult
    func set(_ value: Bool, forKey key: String,
             withAccess access: DSKeychainAccessOptions? = nil) -> Bool {
        
        let bytes: [UInt8] = value ? [1] : [0]
        let data = Data(bytes)
        
        return set(data, forKey: key, withAccess: access)
    }
    
    /// Retrieves the text value from the keychain that corresponds to the given key
    func get(_ key: String) -> String? {
        if let data = getData(key) {
            
            if let currentString = String(data: data, encoding: .utf8) {
                return currentString
            }
            
            lastResultCode = -67853 // errSecInvalidEncoding
        }
        
        return nil
    }
    
    /// Retrieves the data from the keychain that corresponds to the given key
    func getData(_ key: String, asReference: Bool = false) -> Data? {
        // The lock prevents the code to be run simultaneously
        // from multiple threads which may result in crashing
        lock.lock()
        defer { lock.unlock() }
        
        let prefixedKey = keyWithPrefix(key)
        
        var query: [String: Any] = [
            DSKeychainConstants.klass       : kSecClassGenericPassword,
            DSKeychainConstants.attrAccount : prefixedKey,
            DSKeychainConstants.matchLimit  : kSecMatchLimitOne
        ]
        
        if asReference {
            query[DSKeychainConstants.returnReference] = kCFBooleanTrue
        } else {
            query[DSKeychainConstants.returnData] =  kCFBooleanTrue
        }
        
        query = addSynchronizableIfRequired(query, addingItems: false)
        lastQueryParameters = query
        
        var result: AnyObject?
        
        lastResultCode = withUnsafeMutablePointer(to: &result) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        if lastResultCode == noErr {
            return result as? Data
        }
        
        return nil
    }
    
    /// Deletes all Keychain items used by the app. Note that this method deletes all items regardless of the prefix settings used for initializing the class.
    @discardableResult
    func clear() -> Bool {
        lock.lock()
        defer { lock.unlock() }
        
        var query: [String: Any] = [ kSecClass as String : kSecClassGenericPassword ]
        query = addSynchronizableIfRequired(query, addingItems: false)
        lastQueryParameters = query
        
        lastResultCode = SecItemDelete(query as CFDictionary)
        
        return lastResultCode == noErr
    }
    
    /// Returns the key with currently set prefix.
    func keyWithPrefix(_ key: String) -> String {
        return "\(keyPrefix)\(key)"
    }
    
    /// Adds kSecAttrSynchronizable: kSecAttrSynchronizableAny` item to the dictionary when the `synchronizable` property is true.
    func addSynchronizableIfRequired(
        _ items: [String: Any],
        addingItems: Bool
    ) -> [String: Any] {
        
        if !synchronizable { return items }
        var result: [String: Any] = items
        result[DSKeychainConstants.attrSynchronizable] = addingItems == true ? true : kSecAttrSynchronizableAny
        return result
    }
}
