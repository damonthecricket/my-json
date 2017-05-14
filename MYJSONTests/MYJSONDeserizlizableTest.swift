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
        if testJSON.isValue {
            let model = AccountTestClass.self <- testJSON
            
            XCTAssertEqual(model.id, testJSON.string(forKey: "id"))
            XCTAssertEqual(model.index, testJSON.number(forKey: "index").uintValue)
            XCTAssertEqual(model.guid, testJSON.string(forKey: "guid"))
            XCTAssertEqual(model.isActive, testJSON.number(forKey: "isActive").boolValue)
            XCTAssertEqual(model.balance, testJSON.string(forKey: "balance"))
            XCTAssertEqual(model.picture, testJSON.string(forKey: "picture"))
            XCTAssertEqual(model.age, testJSON.number(forKey: "age").uintValue)
            XCTAssertEqual(model.eyeColor, testJSON.string(forKey: "eyeColor"))
            XCTAssertEqual(model.name, testJSON.string(forKey: "name"))
            XCTAssertEqual(model.gender.rawValue, testJSON.string(forKey: "gender"))
            XCTAssertEqual(model.company, testJSON.string(forKey: "company"))
            XCTAssertEqual(model.email, testJSON.string(forKey: "email"))
            XCTAssertEqual(model.phone, testJSON.string(forKey: "phone"))
            XCTAssertEqual(model.address, testJSON.string(forKey: "address"))
            XCTAssertEqual(model.about, testJSON.string(forKey: "about"))
            XCTAssertEqual(model.registered, testJSON.string(forKey: "registered"))
            XCTAssertEqual(model.latitude, testJSON.number(forKey: "latitude").doubleValue)
            XCTAssertEqual(model.longitude, testJSON.number(forKey: "longitude").doubleValue)
            XCTAssertEqual(model.tags, testJSON.getArray(forKey: "tags"))
            

            for (idx, friendJSON) in testJSON.jsonArray(forKey: "friends").enumerated() {
                XCTAssertEqual(model.friends[idx].id, friendJSON.number(forKey: "id").uintValue)
                XCTAssertEqual(model.friends[idx].name, friendJSON.string(forKey: "name"))
            }
            
            XCTAssertEqual(model.greeting, testJSON.string(forKey: "greeting"))
            XCTAssertEqual(model.favoriteFruit, testJSON.string(forKey: "favoriteFruit"))

        }
    }
    
    func testArrayDeserialization() {
        if testJSON.isArray {
            let accounts: [AccountTestClass] = AccountTestClass.self <- testJSON.array
            
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
                XCTAssertEqual(account.tags, json.array(forKey: "tags"), "IDX = \(idx)")

                for (idx, friendJSON) in testJSON.jsonArray(forKey: "friends").enumerated() {
                    XCTAssertEqual(account.friends[idx].id, friendJSON.number(forKey: "id").uintValue, "IDX = \(idx)")
                    XCTAssertEqual(account.friends[idx].name, friendJSON.string(forKey: "name"), "IDX = \(idx)")
                }
                
                XCTAssertEqual(account.greeting, json.string(forKey: "greeting"), "IDX = \(idx)")
                XCTAssertEqual(account.favoriteFruit, json.string(forKey: "favoriteFruit"), "IDX = \(idx)")
            }
        }
    }
}
