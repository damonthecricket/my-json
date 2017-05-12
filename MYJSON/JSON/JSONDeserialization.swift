//
//  JSONDeserialization.swift
//  MYUtils
//
//  Created by Optimus Prime on 04.05.17.
//  Copyright © 2017 Trenlab. All rights reserved.
//

import Foundation

// MARK: - MYJSONDeserizlizable

public protocol MYJSONDeserizlizable {
    init(json: MYJSON)
}

// MARK: - Assignment

public func <- <T>(lft: inout T?, rgt: Any?) {
    lft = Transform(model: lft, data: rgt)
}

public func <- <T>(lft: inout  T, rgt: Any?) {
    if let transform = Transform(model: lft, data: rgt) {
        lft = transform
    }
}

// MARK: - Deserizlizable

public func <- <T: MYJSONDeserizlizable>(lhs: T.Type, rhs: Any?) -> T? {
    var model: T? = nil
    guard let right = rhs else {
        return nil
    }
    
    switch right {
    case is MYJSON:
        let json: MYJSON = right as! MYJSON
        model = lhs <- json
    case is MYJSONType:
        let json = (right as! MYJSONType)
        model = lhs <- json
    case is MYJSONArrayType:
        let json = MYJSON(rawValue: right)
        model = lhs <- json
    case is T:
        model = right as? T
    default:
        break
    }
    return model
}

public func <- <T: MYJSONDeserizlizable>(lhs: T.Type, rhs: Any?) -> [T] {
    var models: [T] = []
    
    guard let right = rhs else {
        return models
    }

    switch right {
    case is MYJSON:
        switch (right as! MYJSON) {
        case .value(let json):
            let model = lhs <- json
            models.append(model)
        case .array(let jsonArray):
            let json = jsonArray
            models = lhs <- json
        }
    case is [MYJSON]:
        let jsonArray = right as! [MYJSON]
        models = jsonArray.map{(json: MYJSON) -> T in
            return lhs <- json
        }
    case is MYJSONType:
        let json: MYJSONType = right as! MYJSONType
        let model = lhs <- json
        models.append(model)
    case is MYJSONArrayType:
        let jsonArray: MYJSONArrayType = right as! MYJSONArrayType
        models = lhs <- jsonArray
    case is T:
        models.append(right as! T)
    case is [T]:
        models.append(contentsOf: (right as! [T]))
    default:
        break
    }
    return models
}

public func <- <T: MYJSONDeserizlizable>(lhs: T.Type, rhs: MYJSON) -> T {
    return lhs.init(json: rhs)
}

public func <- <T: MYJSONDeserizlizable>(lhs: T.Type, rhs: MYJSONArrayType) -> [T] {
    var array: [T] = []
    
    for json in rhs {
        let model: T = lhs <- json
        array.append(model)
    }
    return array
}

public func <- <T: MYJSONDeserizlizable>(lhs: T.Type, rhs: MYJSONType) -> T {
    return T(json: MYJSON(rawValue: rhs))
}

// MARK: - Enum

public func <- <T: RawRepresentable>(lft: inout T, rgt: Any?) {
    guard let right = rgt else {
        return
    }
    guard right is T.RawValue else {
        return
    }
    
    if let transform = Transform(model: lft, data: T(rawValue: right as! T.RawValue)) {
        lft = transform
    }
}

public func <- <T: RawRepresentable>(lft: inout T?, rgt: Any?) {
    guard let right = rgt else {
        return
    }
    guard right is T.RawValue else {
        return
    }
    
    lft = Transform(model: lft, data: T(rawValue: right as! T.RawValue))
}

// MARK: - Transform

public func Transform<T>(model: T?, data: Any?) -> T? {
    guard let _ = data else {
        return nil
    }
    guard data! is T else {
        return nil
    }
    
    return data as! T?
}

// MARK: - Dserialization

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
