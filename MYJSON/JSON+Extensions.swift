//
//  ModelTypes.swift
//  InstaCollage
//
//  Created by Optimus Prime on 11.02.17.
//  Copyright © 2017 Tren Lab. All rights reserved.
//

import Foundation

// MARK: - JSON Extensions

public extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    
    // MARK: - Is
    
    /**
     Returns `true` if instance has сorresponding `JSON` value for key.
     Otherwise, returns empty `false`.
     
     - Parameters:
        - key: A key to find in the dictionary.
     */
    public func isJSON(forKey key: Key) -> Bool {
        return isValue(forKey: key) && self[key] is MYJSON
    }
    
    /**
     Returns `true` if instance has сorresponding `dictionary array` value for key.
     Otherwise, returns empty `false`.
     
     - Parameters:
        - key: A key to find in the dictionary.
     */
    public func isJSONArray(forKey key: Key) -> Bool {
        return isValue(forKey: key) && self[key] is [MYJSON]
    }
    
    /**
     Returns `true` if instance has a `value` for сorresponding key.
     Otherwise, returns empty `false`.
     
     - Parameters:
        - key: A key to find in the dictionary.
     */
    public func isValue(forKey key: Key) -> Bool {
        return self[key] != nil
    }
    
    // MARK: - JSON
    
    /**
     Returns `JSON` for key if instance has сorresponding `JSON` value for key.
     Otherwise, returns empty `dictionary`.
     
     - Parameters:
        - key: A key to find in the dictionary.
     */
    public func json(forKey key: Key) -> MYJSONType {
        guard isJSON(forKey: key) else {
            return [:]
        }
        return self[key] as! MYJSONType
    }
    
    /**
     Returns JSON `array` if instance has сorresponding JSON `array` value for key.
     Otherwise, returns empty `array`.
     
     - Parameters:
        - key: A key to find in the dictionary.
     */
    public func jsonArray(forKey key: Key) -> MYJSONArrayType {
        guard isJSONArray(forKey: key) else {
            return []
        }
        return self[key] as! MYJSONArrayType
    }
    
    // MARK: - Number
    
    /**
     Returns `number` if instance has сorresponding `number` value for key.
     Otherwise, returns empty `number`.
     
     - Parameters:
        - key: A key to find in the dictionary.
     */
    public func number(forKey key: Key) -> NSNumber {
        guard isValue(forKey: key) else {
            return NSNumber()
        }
        guard let number = self[key] as? NSNumber else {
            return NSNumber()
        }
        return number
    }
    
    // MARK: - String
    
    /**
     Returns `string` if instance has сorresponding `string` value for key.
     Otherwise, returns empty `string`.
     
     - Parameters:
        - key: A key to find in the dictionary.
     */
    public func string(forKey key: Key) -> String {
        guard isValue(forKey: key), let str = self[key] as? String else {
            return ""
        }
        return str
    }
    
    // MARK: - Array
    
    /**
     Returns `array` if instance has сorresponding `array` value for key.
     Otherwise, returns empty `array`.
     
     - Parameters:
        - key: A key to find in the dictionary.
     */
    public func array<T>(forKey key: Key) -> [T] {
        guard isValue(forKey: key), let array = self[key] as? [T] else {
            return []
        }
        return array
    }
}

// MARK: - JSON Equality

/**
 Returns `true` if lhs and rhs are equal.
 Otherwise, returns `false`.
 
 - Parameters:
    - lhs: Left operand.
    - rhs: Right operand.
 */
public func == (lhs: MYJSONType, rhs: MYJSONType) -> Bool {
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}

/**
 Returns `true` if lhs and rhs are equal.
 Otherwise, returns `false`.
 
 - Parameters:
    - lhs: Left operand.
    - rhs: Right operand.
 */
public func == (lhs: MYJSONArrayType, rhs: MYJSONArrayType) -> Bool {
    return NSArray(array: lhs).isEqual(to: rhs)
}
