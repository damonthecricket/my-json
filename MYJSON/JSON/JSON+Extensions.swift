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
    
    public func isJSON(forKey key: Key) -> Bool {
        return isValue(forKey: key) && self[key] is MYJSON
    }
    
    public func isJSONArray(forKey key: Key) -> Bool {
        return isValue(forKey: key) && self[key] is [MYJSON]
    }
    
    public func isValue(forKey key: Key) -> Bool {
        return self[key] != nil
    }
    
    // MARK: - JSON
    
    public func json(forKey key: Key) -> MYJSON? {
        guard isJSON(forKey: key) else {
            return nil
        }
        return self[key] as! MYJSON?
    }
    
    public func jsonArray(forKey key: Key) -> [MYJSON]? {
        guard isJSONArray(forKey: key) else {
            return nil
        }
        return self[key] as! [MYJSON]?
    }
    
    // MARK: - Number
    
    public func number(forKey key: Key) -> NSNumber? {
        guard isValue(forKey: key) else {
            return nil
        }
        guard let number = self[key] as? NSNumber? else {
            return nil
        }
        return number
    }
    
    // MARK: - String
    
    public func string(forKey key: Key) -> String? {
        guard isValue(forKey: key), let str = self[key] as? String? else {
            return nil
        }
        return str
    }
}

// MARK: - JSON Equality

public func == (lhs: MYJSONType, rhs: MYJSONType) -> Bool {
    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
}

public func == (lhs: MYJSONArrayType, rhs: MYJSONArrayType) -> Bool {
    return NSArray(array: lhs).isEqual(to: rhs)
}
