//
//  MYJSONDeserizlizableTest.swift
//  MYJSON
//
//  Created by Optimus Prime on 05.05.17.
//  Copyright © 2017 Trenlab. All rights reserved.
//

import XCTest
@testable import MYJSON

class MYJSONDeserizlizableTest: XCTestCase {
    
    var testJSON: MYJSON = MYJSON(rawValue: TestJSON)

    // MARK: - Deserialization
    
    func testValueDeserialization() {
        switch testJSON {
        case .value(let json):
            
            let model = AccountTestClass.self <- json
            
            XCTAssertEqual(model.id, json.string(forKey: "id"))
            XCTAssertEqual(model.index, json.number(forKey: "index").uintValue)
            XCTAssertEqual(model.guid, json.string(forKey: "guid"))
            XCTAssertEqual(model.isActive, json.number(forKey: "isActive").boolValue)
            XCTAssertEqual(model.balance, json.string(forKey: "balance"))
            XCTAssertEqual(model.picture, json.string(forKey: "picture"))
            XCTAssertEqual(model.age, json.number(forKey: "age").uintValue)
            XCTAssertEqual(model.eyeColor, json.string(forKey: "eyeColor"))
            XCTAssertEqual(model.name, json.string(forKey: "name"))
            XCTAssertEqual(model.gender.rawValue, json.string(forKey: "gender"))
            XCTAssertEqual(model.company, json.string(forKey: "company"))
            XCTAssertEqual(model.email, json.string(forKey: "email"))
            XCTAssertEqual(model.phone, json.string(forKey: "phone"))
            XCTAssertEqual(model.address, json.string(forKey: "address"))
            XCTAssertEqual(model.about, json.string(forKey: "about"))
            XCTAssertEqual(model.registered, json.string(forKey: "registered"))
            XCTAssertEqual(model.latitude, json.number(forKey: "latitude").doubleValue)
            XCTAssertEqual(model.longitude, json.number(forKey: "longitude").doubleValue)
            XCTAssertEqual(model.tags, json["tags"] as! [String])
            
            let friendsJSON = json["friends"] as! [MYJSONType]
            for (idx, friendJSON) in friendsJSON.enumerated() {
                XCTAssertEqual(model.friends[idx].id, friendJSON.number(forKey: "id").uintValue)
                XCTAssertEqual(model.friends[idx].name, friendJSON.string(forKey: "name"))
            }
            
            XCTAssertEqual(model.greeting, json.string(forKey: "greeting"))
            XCTAssertEqual(model.favoriteFruit, json.string(forKey: "favoriteFruit"))
        default:
            break
        }
    }
    
    func testArrayDeserialization() {
        switch testJSON {
        case .array(let jsonArray):
            let accounts: [AccountTestClass] = AccountTestClass.self <- jsonArray
            
            for (idx, account) in accounts.enumerated() {
                
                let json: MYJSONType = testJSON.array![idx]
                
                XCTAssertEqual(account.id, json.string(forKey: "id"), "IDX = \(idx)")
                XCTAssertEqual(account.index, json.number(forKey: "index").uintValue, "IDX = \(idx)")
                XCTAssertEqual(account.guid, json.string(forKey: "guid"), "IDX = \(idx)")
                XCTAssertEqual(account.isActive, json.number(forKey: "isActive").boolValue, "IDX = \(idx)")
                XCTAssertEqual(account.balance, json.string(forKey: "balance"), "IDX = \(idx)")
                XCTAssertEqual(account.picture, json.string(forKey: "picture"), "IDX = \(idx)")
                XCTAssertEqual(account.age, json.number(forKey: "age").uintValue, "IDX = \(idx)")
                XCTAssertEqual(account.eyeColor, json.string(forKey: "eyeColor"), "IDX = \(idx)")
                XCTAssertEqual(account.name, json.string(forKey: "name"), "IDX = \(idx)")
                XCTAssertEqual(account.gender.rawValue, json.string(forKey: "gender"), "IDX = \(idx)")
                XCTAssertEqual(account.company, json.string(forKey: "company"), "IDX = \(idx)")
                XCTAssertEqual(account.email, json.string(forKey: "email"), "IDX = \(idx)")
                XCTAssertEqual(account.phone, json.string(forKey: "phone"), "IDX = \(idx)")
                XCTAssertEqual(account.address, json.string(forKey: "address"), "IDX = \(idx)")
                XCTAssertEqual(account.about, json.string(forKey: "about"), "IDX = \(idx)")
                XCTAssertEqual(account.registered, json.string(forKey: "registered"), "IDX = \(idx)")
                XCTAssertEqual(account.latitude, json.number(forKey: "latitude").doubleValue, "IDX = \(idx)")
                XCTAssertEqual(account.longitude, json.number(forKey: "longitude").doubleValue, "IDX = \(idx)")
                XCTAssertEqual(account.tags, json["tags"] as! [String])
                
                let friendsJSON = json["friends"] as! [MYJSONType]
                for (idx, friendJSON) in friendsJSON.enumerated() {
                    XCTAssertEqual(account.friends[idx].id, friendJSON.number(forKey: "id").uintValue, "IDX = \(idx)")
                    XCTAssertEqual(account.friends[idx].name, friendJSON.string(forKey: "name"), "IDX = \(idx)")
                }
                
                XCTAssertEqual(account.greeting, json.string(forKey: "greeting"), "IDX = \(idx)")
                XCTAssertEqual(account.favoriteFruit, json.string(forKey: "favoriteFruit"), "IDX = \(idx)")
            }
        default:
            break
        }
    }
}
