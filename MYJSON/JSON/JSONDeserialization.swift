//
//  JSONDeserialization.swift
//  MYUtils
//
//  Created by Optimus Prime on 04.05.17.
//  Copyright © 2017 Trenlab. All rights reserved.
//

import Foundation

// MARK: - MYJSONDeserizlizable

/** 
 A protocol that used to deserialize JSON.
 */
public protocol MYJSONDeserizlizable {
    /**
     Required to implementation initializer.
     In this method deserialize JSON.
     */
    init(json: MYJSON)
}

// MARK: - Assignment

/** 
 Assigns right value to left value.
 
     let a = right <- json["key"]

 - Parameters:
    - lft: Left value.
    - rgt: Right value.
 */
public func <- <T>(lhs: inout T?, rhs: Any?) {
    lhs = Transform(data: rhs)
}

/**
 Assigns right value to left value.
 
 If right operand is `nil`, then the assignment does not occur.
 
     let a = right <- json["key"]
 
 - Parameters:
    - lft: Left value.
    - rgt: Right value.
 */
public func <- <T>(lhs: inout T, rhs: Any?) {
    if let transform: T = Transform(data: rhs) {
        lhs = transform
    }
}

// MARK: - Deserizlizable

/**
 Deserialize right value into and returns T instance.
 Returns `nil`, if rhs is `nil`.
 
     let json = <...>
     let model: User = User.self <- json.
 
 - Parameters:
    - lhs: A class, into wich need deserialize right value. Should conform to MYJSONDeserizlizable protocol.
 
    - rhs: A value, which need to deserialize. Should a type of:
        - MYJSON.
        - MYJSONType.
        - MYJSONArrayType.
        - T.
 
        Otherwise, returns `nil`.
 */
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

/**
 Deserialize right value into array of T type.
 Returns empty array, if rhs is `nil`.
 
     let json = <...>
     let model: [User] = User.self <- json.
 
 - Parameters:
    - lhs: A class into wich need deserialize right value. Should conform to MYJSONDeserizlizable protocol.
 
    - rhs: A value, which need to deserialize. Should a type of:
        - MYJSON.
        - [MYJSON].
        - MYJSONType.
        - MYJSONArrayType.
        - T.
        - [T].
           
        Otherwise, returns empty array.
 */
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

/**
 Returns deserialized instance of class T.
 
     let json: MYJSON = <...>
     let model: User = User.self <- json.
 
    - Parameters:
        - lhs: A class into wich need deserialize right value. Should conform to MYJSONDeserizlizable protocol.
        - rhs: A value, which need to deserialize.
 */
public func <- <T: MYJSONDeserizlizable>(lhs: T.Type, rhs: MYJSON) -> T {
    return lhs.init(json: rhs)
}

/**
 Returns deserialized array of class T.
 
     let json: MYJSONArrayType = <...>
     let model: [User] = User.self <- json.
 
    - Parameters:
        - lhs: A class into wich need deserialize right value. Should conform to MYJSONDeserizlizable protocol.
        - rhs: A value, which need to deserialize.
 */
public func <- <T: MYJSONDeserizlizable>(lhs: T.Type, rhs: MYJSONArrayType) -> [T] {
    var array: [T] = []
    
    for json in rhs {
        let model: T = lhs <- json
        array.append(model)
    }
    return array
}

/**
 Returns deserialized instance of class T.
 
     let json: MYJSONType = <...>
     let model: User = User.self <- json.
 
    - Parameters:
        - lhs: A class into wich need to deserialize right value. Should conform to MYJSONDeserizlizable protocol.
        - rhs: A value, which need to deserialize.
 */
public func <- <T: MYJSONDeserizlizable>(lhs: T.Type, rhs: MYJSONType) -> T {
    return T(json: MYJSON(rawValue: rhs))
}

// MARK: - Enum

/**
 Returns deserialization RawRepresentable instance.
 If right operand is `nil`, then the assignment does not occur.
 
     enum Gender: String {
        case male = "male"
        case female = "female"
     }
 
     gender <- json["gender"].
 
    - Parameters:
        - lhs: An instance into wich need to deserialize right value. Should conform to RawRepresentable protocol.
        - rhs: A value, which need to deserialize.
 */
public func <- <T: RawRepresentable>(lhs: inout T, rhs: Any?) {
    guard let right = rhs else {
        return
    }
    guard right is T.RawValue else {
        return
    }
    
    if let transform: T = Transform(data: T(rawValue: right as! T.RawValue)) {
        lhs = transform
    }
}

/**
 Returns deserialized RawRepresentable instance.
 
     enum Gender: String {
        case male = "male"
        case female = "female"
     }
 
     gender <- json["gender"].
 
    - Parameters:
        - lhs: An instance into wich need to deserialize right value. Should conform to RawRepresentable protocol.
        - rhs: A value, which need to deserialize.
 */
public func <- <T: RawRepresentable>(lhs: inout T?, rhs: Any?) {
    guard let right = rhs else {
        return
    }
    guard right is T.RawValue else {
        return
    }
    
    lhs = Transform(data: T(rawValue: right as! T.RawValue))
}

// MARK: - Transform

/**
 Transform data into T value.
 
 - Parameters:

    - data: A value, which need to transform.
 */
public func Transform<T>(data: Any?) -> T? {
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
    
    /**
     Deserialize data with JSONSerialization.ReadingOptions.mutableContainers
     options and returns a new instance.
     
        - Parameters:
            - data: A data object containing JSON data.
     */
    public class func mutableContainersJSON(with data: Data) throws -> MYJSON {
        return try json(with: data, options: [JSONSerialization.ReadingOptions.mutableContainers])
    }
    
    /**
     Deserialize raw data with JSONSerialization.ReadingOptions.mutableLeaves options
     and returns a new instance.
     
     - Parameters:
        - data: A data object containing JSON data.
     */
    public class func mutableLeavesJSON(with data: Data) throws -> MYJSON {
        return try json(with: data, options: [JSONSerialization.ReadingOptions.mutableLeaves])
    }
    
    /**
     Deserialize raw data with JSONSerialization.ReadingOptions.allowFragments options
     and returns a new instance.
     
     - Parameters:
        - data: A data object containing JSON data.
     */
    public class func allowFragmentsJSON(with data: Data) throws -> MYJSON {
        return try json(with: data, options: [JSONSerialization.ReadingOptions.allowFragments])
    }
    
    /**
     Deserialize raw data with specified options
     and returns a new instance.
     
     - Parameters:
        - data:    A data object containing JSON data.
        - options: Options for reading the JSON data and creating the Foundation objects.
     */
    public class func json(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> MYJSON {
        let object = try JSONSerialization.jsonObject(with: data, options: opt)
        
        let json = MYJSON(rawValue: object)
        
        return json
    }
}
