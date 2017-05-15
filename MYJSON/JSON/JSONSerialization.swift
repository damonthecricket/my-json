//
//  JSONSerialization.swift
//  MYUtils
//
//  Created by Optimus Prime on 04.05.17.
//  Copyright © 2017 Trenlab. All rights reserved.
//

import Foundation

// MARK: - MYJSONSerizlizable

/**
 A protocol that used to serialize JSON.
 */
public protocol MYJSONSerizlizable {
    /**
     Required to implementation variable.
     In this method return JSON representation of your class / structure.
     */
    var json: MYJSON {get}
}

// MARK: - Serialization

public extension JSONSerialization {
    /**
     Returns JSON data from a MYJSON object with JSONSerialization.WritingOptions.prettyPrinted options.
     
     - Parameters:
        - json: The JSON object from which to generate JSON data.
     */
    public class func prettyPrintedData(withJSON json: MYJSON) throws -> Data {
        return try data(withJSON: json, options: [JSONSerialization.WritingOptions.prettyPrinted])
    }
    
    /**
     Returns JSON data from a MYJSON object.

     - Parameters:
        - json:    The JSON object from which to generate JSON data.
        - options: Options for creating the JSON data.
     */
    public class func data(withJSON json: MYJSON, options opt: JSONSerialization.WritingOptions = []) throws -> Data {
        let JSONObject: Any
        switch json {
        case .value(let jsonValue):
            JSONObject = jsonValue
        case .array(let jsonArray):
            JSONObject = jsonArray
        }
        return try JSONSerialization.data(withJSONObject: JSONObject, options: opt)
    }
}
