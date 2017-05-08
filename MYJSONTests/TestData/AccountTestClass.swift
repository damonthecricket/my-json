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
        id <- json.value?["id"]
        index <- json.value?.number(forKey: "index").uintValue
        guid  <- json.value?["guid"]
        isActive <- json.value?.number(forKey: "isActive").boolValue
        balance  <- json.value?["balance"]
        picture  <- json.value?["picture"]
        age      <- json.value?.number(forKey: "age").uintValue
        eyeColor <- json.value?["eyeColor"]
        name     <- json.value?["name"]
        gender   <- json.value?["gender"]
        company  <- json.value?["company"]
        email    <- json.value?["email"]
        phone    <- json.value?["phone"]
        address  <- json.value?["address"]
        about    <- json.value?["about"]
        registered <- json.value?["registered"]
        latitude   <- json.value?.number(forKey: "latitude").doubleValue
        longitude  <- json.value?.number(forKey: "longitude").doubleValue
        tags       <- json.value?["tags"]
        friends    = (FriendTestClass.self <- json.value?["friends"])
        greeting   <- json.value?["greeting"]
        favoriteFruit <- json.value?["favoriteFruit"]
    }
}
