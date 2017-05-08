//
//  JSONSerialization.swift
//  MYUtils
//
//  Created by Optimus Prime on 04.05.17.
//  Copyright © 2017 Trenlab. All rights reserved.
//

// MARK: - MYJSONSerizlizable

public protocol MYJSONSerizlizable {
    var json: MYJSON {get}
}

// MARK: - Serialization

public extension JSONSerialization {
    public class func prettyPrintedData(withJSON json: MYJSON) throws -> Data {
        return try data(withJSON: json, options: [JSONSerialization.WritingOptions.prettyPrinted])
    }
    
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
