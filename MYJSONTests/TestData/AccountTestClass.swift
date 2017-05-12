//
//  TestClass.swift
//  MYJSON
//
//  Created by Optimus Prime on 06.05.17.
//  Copyright © 2017 Trenlab. All rights reserved.
//

import Foundation
import MYJSON

public enum GenderTestEnum: String {
    
    case male = "male"
    
    case female = "female"
}

public class AccountTestClass: MYJSONSerizlizable, MYJSONDeserizlizable {
    
    public var id: String = ""
    
    public var index: UInt = 0
    
    public var guid: String = ""
    
    public var isActive: Bool = false
    
    public var balance: String = ""
    
    public var picture: String = ""
    
    public var age: UInt = 0
    
    public var eyeColor: String = ""
    
    public var name: String = ""
    
    public var gender: GenderTestEnum = .male
    
    public var company: String = ""
    
    public var email: String = ""
    
    public var phone: String = ""
    
    public var address: String = ""
    
    public var about: String = ""
    
    public var registered: String = ""
    
    public var latitude: Double = 0.0
    
    public var longitude: Double = 0.0
    
    public var tags: [String] = []
    
    public var friends: [FriendTestClass] = []
    
    public var greeting: String = ""
    
    public var favoriteFruit: String = ""
    
    public var json: MYJSON {
        return MYJSON(rawValue: ["id": id, "index": "\(index)", "guid": guid])
    }
    
    // MARK: - Object LifeCycle
    
    public required init(json: MYJSON) {
        id    <- json["id"]
        index <- json.number(forKey: "index").uintValue
        guid  <- json["guid"]
        isActive <- json.number(forKey: "isActive").boolValue
        balance  <- json["balance"]
        picture  <- json["picture"]
        age      <- json.number(forKey: "age").uintValue
        eyeColor <- json["eyeColor"]
        name     <- json["name"]
        gender   <- json["gender"]
        company  <- json["company"]
        email    <- json["email"]
        phone    <- json["phone"]
        address  <- json["address"]
        about    <- json["about"]
        registered <- json["registered"]
        latitude   <- json.number(forKey: "latitude").doubleValue
        longitude  <- json.number(forKey: "longitude").doubleValue
        tags       <- json["tags"]
        friends    = (FriendTestClass.self <- json["friends"])
        greeting   <- json["greeting"]
        favoriteFruit <- json["favoriteFruit"]
    }
}
