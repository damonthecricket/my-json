//
//  Model.swift
//  InstaCollage
//
//  Created by Optimus Prime on 07.02.17.
//  Copyright © 2017 Tren Lab. All rights reserved.
//

import Foundation

// MARK: - Types

public typealias MYJSONArrayType = [MYJSONType]

public typealias MYJSONType = [MYJSONKey: MYJSONValue]

public typealias MYJSONKey = String

public typealias MYJSONValue = Any

// MARK: - MYJSON

public let MYEmptyJSON: MYJSON = .value(["Empty": "JSON"])

public enum MYJSON: RawRepresentable {
    
    public typealias RawValue = Any
    
    case value(MYJSONType)
    
    case array(MYJSONArrayType)
    
    // MARK: - Object LifeCycle

    public init(withMutableContainersJSONData data: Data) throws {
        try self.init(with: data, options: [JSONSerialization.ReadingOptions.mutableContainers])
    }
    
    public init(withMutableLeavesJSONData data: Data) throws {
        try self.init(with: data, options: [JSONSerialization.ReadingOptions.mutableLeaves])
    }
    
    public init(withAllowFragmentsJSONData data: Data) throws {
        try self.init(with: data, options: [JSONSerialization.ReadingOptions.allowFragments])
    }
    
    public init(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws {
        let object = try JSONSerialization.jsonObject(with: data, options: opt)

        self = MYJSON(rawValue: object)
    }
    
    public init() {
        self = MYEmptyJSON
    }
    
    public init(rawValue: Any) {
        switch rawValue {
        case is MYJSONType:
            self = .value(rawValue as! MYJSONType)
        case is MYJSONArrayType:
            self = .array(rawValue as! MYJSONArrayType)
        default:
            self = MYEmptyJSON
        }
    }
    
    public init(value: MYJSONType) {
        self = .value(value)
    }
    
    public init(array: MYJSONArrayType) {
        self = .array(array)
    }

    // MARK: - RawRepresentable
    
    public var rawValue: RawValue {
        return isValue ? value as Any : array as Any
    }
    
    public var value: MYJSONType? {
        if case .value(let json) = self {
            return json
        }
        return nil
    }
    
    public var array: MYJSONArrayType? {
        if case .array(let array) = self {
            return array
        }
        return nil
    }
    
    // MARK: - Is
    
    public var isEmpty: Bool {
        return isValue && self == MYEmptyJSON
    }
    
    public var isValue: Bool {
        if case .value(_) = self {
            return true
        } else {
            return false
        }
    }
    
    public var isArray: Bool {
        if case .array(_) = self {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Handle
    
    public func handle<T>(value: (MYJSONType) -> T, array: (MYJSONArrayType) -> T) -> T {
        switch self {
        case      .value(let json): return value(json)
        case .array(let jsonArray): return array(jsonArray)
        }
    }
}

// MARK: - MYJSON CustomStringConvertible, CustomDebugStringConvertible

extension MYJSON:  CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return handle(
            value: { ".VALUE(\($0))" },
            array: { ".ARRAY(\($0))" }
        )
    }
    
    public var debugDescription: String {
        return description
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

// MARK: - MYJSON


// MARK: - Deserialization

public extension JSONSerialization {
    
    public class func mutableContainersJSON(with data: Data) throws -> MYJSON {
        return try MYJSON(withMutableContainersJSONData: data)
    }
    
    public class func mutableLeavesJSON(with data: Data) throws -> MYJSON {
        return try MYJSON(withMutableLeavesJSONData: data)
    }
    
    public class func allowFragmentsJSON(with data: Data) throws -> MYJSON {
        return try MYJSON(withAllowFragmentsJSONData: data)
    }
    
    public class func json(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> MYJSON {
        return try MYJSON(with: data, options: opt)
    }
}
