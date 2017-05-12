//
//  FriendTestClass.swift
//  MYJSON
//
//  Created by Optimus Prime on 08.05.17.
//  Copyright © 2017 Trenlab. All rights reserved.
//

import Foundation
import MYJSON

// MARK: - FriendTestClass

public class FriendTestClass: MYJSONSerizlizable, MYJSONDeserizlizable {
    
    public var id: UInt = 0
    
    public var name: String = ""

    public var json: MYJSON {
        return MYJSON(rawValue: ["id": id, "name": name])
    }
    
    // MARK: - Object LifeCycle
    
    public required init(json: MYJSON) {
        id   <- json.number(forKey: "id").uintValue
        name <- json["name"]
    }
}

extension FriendTestClass: Equatable {
    public static func ==(lhs: FriendTestClass, rhs: FriendTestClass) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
