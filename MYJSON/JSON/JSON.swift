//
//  Model.swift
//  InstaCollage
//
//  Created by Optimus Prime on 07.02.17.
//  Copyright © 2017 Tren Lab. All rights reserved.
//

import Foundation

// MARK: - Types

/** 
 JSON array type. 
 */
public typealias MYJSONArrayType = [MYJSONType]

/** 
 JSON type.
    - key is `String` type.
 
 
    - value is `Any` type. 
 */
public typealias MYJSONType = [MYJSONKey: MYJSONValue]

/**  
 JSON key is `String` type. 
 */
public typealias MYJSONKey = String

/** 
 JSON value is `Any` type.
 */
public typealias MYJSONValue = Any

// MARK: - MYJSON

/** 
 Empty JSON constant equal to [:].
 */
public let MYEmptyJSON: MYJSONType = [:] as MYJSONType

/** 
 Used to represent a JSON as dictionary or array of dictionaries.
 
    - value(MYJSONType):      JSON is a dictionary.

 
    - array(MYJSONArrayType): JSON is an array.
 */
public enum MYJSON: RawRepresentable {

    public typealias RawValue = Any
    
    /**
     `MYJSON` enum value with associated MYJSONType value.
     */
    case value(MYJSONType)
    
    /**z
     `MYJSON` enum value with associated MYJSONArrayType value.
     */
    case array(MYJSONArrayType)

    // MARK: - Object LifeCycle

    /**
    Creates a new instance with empty JSON (single value [:]).
     */
    public init() {
        self.init(rawValue: MYEmptyJSON)
    }
    
    /** 
     Deserialize raw value and creates a new instance.
     
     - Parameters:
        - rawValue: An input parameter witch should be type of MYJSONType or MYJSONArrayType.
                    Otherwise, creates an empty example.
     */
    public init(rawValue: Any) {
        switch rawValue {
        case is MYJSONType:
            self = .value(rawValue as! MYJSONType)
        case is MYJSONArrayType:
            self = .array(rawValue as! MYJSONArrayType)
        default:
            self = .value(MYEmptyJSON)
        }
    }

    // MARK: - RawRepresentable
    
    /**
     Returns `RawValue`.
     */
    public var rawValue: RawValue {
        return isValue ? value as Any : array as Any
    }
    
    /**
     Returns instance of `MYJSONType` if the JSON is a dictionary, `nil` otherwise.
     */
    public var value: MYJSONType? {
        if case .value(let json) = self {
            return json
        }
        return nil
    }
    
    /**
     Returns instance of `MYJSONArrayType` if the JSON is an array of dictionaries, `nil` otherwise.
     */
    public var array: MYJSONArrayType? {
        if case .array(let array) = self {
            return array
        }
        return nil
    }
    
    // MARK: - Is
    
    /**
     Returns `true` if the JSON is a empty, `false` otherwise.
     */
    public var isEmpty: Bool {
        if isValue {
            return value! == MYEmptyJSON
        } else {
            return array!.count == 1 && array![0] == MYEmptyJSON
        }
    }
    
    /**
     Returns `true` if the JSON is a value, `false` otherwise. 
     */
    public var isValue: Bool {
        if case .value(_) = self {
            return true
        } else {
            return false
        }
    }
    
    /**
     Returns `true` if the JSON is a array, `false` otherwise.
     */
    public var isArray: Bool {
        if case .array(_) = self {
            return true
        } else {
            return false
        }
    }
    
    
    
    // MARK: - Handle
    
    /**
     Handle JSON.

     - Parameters:
        - value: `Closure`, that called if instance contains a dictionary and delivers associated MYJSONType value as parameter.
        - array: `Closure`, that called if instance contains an array of dictionaries and delivers associated MYJSONArrayType value as      parameter.
     */
    public func handle<T>(value: (MYJSONType) -> T, array: (MYJSONArrayType) -> T) -> T {
        switch self {
        case .value(let json):
            return value(json)
        case .array(let jsonArray):
            return array(jsonArray)
        }
    }
    
    // MARK: - Subscript
    
    /**
     Returns `value` if contains contains a `dictionary` and there is сorresponding key value.
     Otherwise, returns `nil` if there is no сorresponding key value or JSON is an  array.
     
     - Parameters:
         - key: A key to find in the dictionary.
     */
    public subscript(key: MYJSONKey) -> MYJSONValue? {
        set(newValue) {
            switch self {
            case .value(var json):
                if newValue == nil {
                    json.removeValue(forKey: key)
                } else {
                    json[key] = newValue
                }
            case .array(_):
                break
            }
        } get {
            switch self {
            case .value(let json):
                return json[key]
            case .array(_):
                return nil
            }
        }
    }
    
    // MARK: - JSON
    
    /**
     Returns JSON for key if JSON.
     
     - Parameters:
         - key: A key to find in the dictionary.
     */
    public func json(forKey key: MYJSONKey) -> MYJSONType {
        guard isJSON(forKey: key) else {
            return MYEmptyJSON
        }
        return value!.json(forKey: key)
    }
    
    /**
     Returns JSON if instance contains a `dictionary` and there is сorresponding JSON array value for key.
     Otherwise, returns empty `dictionary`.
    
     - Parameters:
         - key: A key to find in the dictionary.
     */
    public func jsonArray(forKey key: MYJSONKey) -> MYJSONArrayType {
        guard isJSONArray(forKey: key) else {
            return []
        }
        return value!.jsonArray(forKey: key)
    }

    // MARK: - Number
    
    /**
     Returns `number` if instance contains a `dictionary` and there is сorresponding `number` value for key.
     Otherwise, returns empty `number`.
     
     - Parameters:
         - key: A key to find in the dictionary.
     */
    public func number(forKey key: MYJSONKey) -> NSNumber {
        guard isValue else {
            return NSNumber()
        }
        return value!.number(forKey: key)
    }
    
    // MARK: - String
    
    /**
     Returns `string` if instance contains a `dictionary` and there is сorresponding `string` value for key.
     Otherwise, returns empty `string`.

     - Parameters:
         - key: A key to find in the dictionary.
     */
    public func string(forKey key: MYJSONKey) -> String {
        guard isValue else {
            return ""
        }
        return value!.string(forKey: key)
    }
    
    // MARK: - Array
    
    /**
     Returns `array` if instance contains a `dictionary` and there is сorresponding `array` value for key.
     Otherwise, returns empty `array`.

     - Parameters:
         - key: A key to find in the dictionary. 
     */
    public func getArray<T>(forKey key: MYJSONKey) -> [T] {
        guard isValue else {
            return []
        }
        return value!.array(forKey: key)
    }

    // MARK: - Is JSON

    /**
     Returns `true` if instance contains a `dictionary` and there is сorresponding JSON value for key.
     Otherwise, returns empty `false`.
     
     - Parameters:
        - key: A key to find in the dictionary.
     */
    public func isJSON(forKey key: MYJSONKey) -> Bool {
        guard isValue else {
            return false
        }
        return value!.isJSON(forKey: key)
    }
    
    /**
     Returns `true` if instance contains a `dictionary array` and there is сorresponding `dictionary array` value for key.
     Otherwise, returns empty `false`.

     - Parameters:
         - key: A key to find in the dictionary.
     */
    public func isJSONArray(forKey key: MYJSONKey) -> Bool {
        guard isValue else {
            return false
        }
        return value!.isJSONArray(forKey: key)
    }
    
    /**
     Returns `true` if instance contains a `value` for сorresponding key.
     Otherwise, returns empty `false`.
     
     - Parameters:
         - key: A key to find in the dictionary.
     */
    public func isValue(forKey key: MYJSONKey) -> Bool {
        guard isValue else {
            return false
        }
        return value!.isValue(forKey: key)
    }
}

// MARK: - MYJSON CustomStringConvertible, CustomDebugStringConvertible

extension MYJSON: CustomStringConvertible, CustomDebugStringConvertible {
    
    /**
     Returns debug description `String`.
     */
    public var debugDescription: String {
        return description
    }
    
    /**
     Returns description `String`.
     */
    public var description: String {
        return handle(
            value: { ".VALUE(\($0))" },
            array: { ".ARRAY(\($0))" }
        )
    }
}

// MARK: - MYJSON Equatable

extension MYJSON: Equatable {
    public static func ==(lhs: MYJSON, rhs: MYJSON) -> Bool {
        if lhs.isValue && rhs.isValue {
            return lhs.value! == rhs.value!
        } else if lhs.isArray && rhs.isArray {
            return lhs.array! == rhs.array!
        }
        return false
    }
}
