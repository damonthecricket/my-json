//
//  MYJSONTests.swift
//  MYJSONTests
//
//  Created by Optimus Prime on 04.05.17.
//  Copyright © 2017 Trenlab. All rights reserved.
//

import XCTest
@testable import MYJSON

class MYJSONTests: XCTestCase {

    fileprivate let testJSON = TestJSON

    fileprivate let testJSONData: Data = try! JSONSerialization.data(withJSONObject: TestJSON, options: [JSONSerialization.WritingOptions.prettyPrinted])
    
    
    fileprivate var mutableContainersJSON: MYJSON?
    
    fileprivate var mutableLeavesJSON: MYJSON?
    
    fileprivate var allowFragmentsJSON: MYJSON?
    
    fileprivate var rawInstalledJSON: MYJSON!

    // MARK: - Setup / Teardown
    
    override func setUp() {
        super.setUp()

        
        mutableContainersJSON = try? MYJSON(withAllowFragmentsJSONData: testJSONData)

        mutableLeavesJSON = try? MYJSON(withMutableLeavesJSONData: testJSONData)
        
        allowFragmentsJSON = try? MYJSON(withAllowFragmentsJSONData: testJSONData)
        
        rawInstalledJSON = MYJSON(rawValue: testJSON)
    }
    
    override func tearDown() {
        mutableContainersJSON = nil
        
        mutableLeavesJSON = nil
        
        allowFragmentsJSON = nil
        
        rawInstalledJSON = nil

        
        super.tearDown()
    }
    
    // MARK: - Instance
    
    func testInstance() {
        XCTAssertNotNil(mutableContainersJSON)
        
        XCTAssertNotNil(mutableLeavesJSON)
        
        XCTAssertNotNil(allowFragmentsJSON)
    }
    
    // MARK: - Types
    
    func testValue() {
        switch testJSON {
        case is MYJSONType:
            XCTAssertTrue(mutableContainersJSON!.isValue)
            XCTAssertTrue(mutableLeavesJSON!.isValue)
            XCTAssertTrue(allowFragmentsJSON!.isValue)
            XCTAssertTrue(rawInstalledJSON.isValue)
            
            XCTAssertFalse(mutableContainersJSON!.isArray)
            XCTAssertFalse(mutableLeavesJSON!.isArray)
            XCTAssertFalse(allowFragmentsJSON!.isArray)
            XCTAssertFalse(rawInstalledJSON.isArray)
            
            XCTAssertNotNil(mutableContainersJSON!.value)
            XCTAssertNotNil(mutableLeavesJSON!.value)
            XCTAssertNotNil(allowFragmentsJSON!.value)
            XCTAssertNotNil(rawInstalledJSON.value)
            
            XCTAssertNil(mutableContainersJSON!.array)
            XCTAssertNil(mutableLeavesJSON!.array)
            XCTAssertNil(allowFragmentsJSON!.array)
            XCTAssertNil(rawInstalledJSON.array)

            let convertedTestJSON: MYJSONType = testJSON as! MYJSONType

            XCTAssertTrue((mutableContainersJSON!.rawValue as! MYJSONType) == convertedTestJSON)
            XCTAssertTrue((mutableLeavesJSON!.rawValue as! MYJSONType) == convertedTestJSON)
            XCTAssertTrue((allowFragmentsJSON!.rawValue as! MYJSONType) == convertedTestJSON)
            XCTAssertTrue((rawInstalledJSON.rawValue as! MYJSONType) == convertedTestJSON)
            
            XCTAssertTrue(mutableContainersJSON!.value! == convertedTestJSON)
            XCTAssertTrue(mutableLeavesJSON!.value! == convertedTestJSON)
            XCTAssertTrue(allowFragmentsJSON!.value! == convertedTestJSON)
            XCTAssertTrue(rawInstalledJSON!.value! == convertedTestJSON)
            
            XCTAssertTrue(mutableContainersJSON!.value! == (mutableContainersJSON!.rawValue as! MYJSONType))
            XCTAssertTrue(mutableLeavesJSON!.value! == (mutableLeavesJSON!.rawValue as! MYJSONType))
            XCTAssertTrue(allowFragmentsJSON!.value! == (allowFragmentsJSON!.rawValue as! MYJSONType))
            XCTAssertTrue(rawInstalledJSON!.value! == (rawInstalledJSON.rawValue as! MYJSONType))
        default:
            break
        }
    }
    
    func testArray() {
        switch testJSON {
        case is MYJSONArrayType:
            XCTAssertTrue(mutableContainersJSON!.isArray)
            XCTAssertTrue(mutableLeavesJSON!.isArray)
            XCTAssertTrue(allowFragmentsJSON!.isArray)
            XCTAssertTrue(rawInstalledJSON.isArray)
            
            XCTAssertFalse(mutableContainersJSON!.isValue)
            XCTAssertFalse(mutableLeavesJSON!.isValue)
            XCTAssertFalse(allowFragmentsJSON!.isValue)
            XCTAssertFalse(rawInstalledJSON.isValue)
            
            XCTAssertNotNil(mutableContainersJSON!.array)
            XCTAssertNotNil(mutableLeavesJSON!.array)
            XCTAssertNotNil(allowFragmentsJSON!.array)
            XCTAssertNotNil(rawInstalledJSON.array)
            
            XCTAssertNil(mutableContainersJSON!.value)
            XCTAssertNil(mutableLeavesJSON!.value)
            XCTAssertNil(allowFragmentsJSON!.value)
            XCTAssertNil(rawInstalledJSON.value)
            
            let convertedTestJSON: MYJSONArrayType = testJSON as! MYJSONArrayType
            
            XCTAssertTrue((mutableContainersJSON!.rawValue as! MYJSONArrayType) == convertedTestJSON)
            XCTAssertTrue((mutableLeavesJSON!.rawValue as! MYJSONArrayType) == convertedTestJSON)
            XCTAssertTrue((allowFragmentsJSON!.rawValue as! MYJSONArrayType) == convertedTestJSON)
            XCTAssertTrue((rawInstalledJSON.rawValue as! MYJSONArrayType) == convertedTestJSON)
            
            XCTAssertTrue(mutableContainersJSON!.array! == convertedTestJSON)
            XCTAssertTrue(mutableLeavesJSON!.array! == convertedTestJSON)
            XCTAssertTrue(allowFragmentsJSON!.array! == convertedTestJSON)
            XCTAssertTrue(rawInstalledJSON!.array! == convertedTestJSON)
            
            XCTAssertTrue(mutableContainersJSON!.array! == (mutableContainersJSON!.rawValue as! MYJSONArrayType))
            XCTAssertTrue(mutableLeavesJSON!.array! == (mutableLeavesJSON!.rawValue as! MYJSONArrayType))
            XCTAssertTrue(allowFragmentsJSON!.array! == (allowFragmentsJSON!.rawValue as! MYJSONArrayType))
            XCTAssertTrue(rawInstalledJSON!.array! == (rawInstalledJSON.rawValue as! MYJSONArrayType))
        default:
            break
        }
    }

    func testEmpty() {
        let convertedTestJSON: MYJSONType? = testJSON as? MYJSONType
        
        if convertedTestJSON != nil && convertedTestJSON!.isEmpty {
            XCTAssertTrue(mutableContainersJSON!.isEmpty)
            XCTAssertTrue(mutableLeavesJSON!.isEmpty)
            XCTAssertTrue(allowFragmentsJSON!.isEmpty)
            XCTAssertTrue(rawInstalledJSON.isEmpty)
        } else {
            XCTAssertFalse(mutableContainersJSON!.isEmpty)
            XCTAssertFalse(mutableLeavesJSON!.isEmpty)
            XCTAssertFalse(allowFragmentsJSON!.isEmpty)
            XCTAssertFalse(rawInstalledJSON.isEmpty)
        }
    }
    
    // MARK: - Data
    
    func testData() {
        XCTAssertNotEqual(try? mutableContainersJSON!.prettyPrintedData(), testJSONData)
        XCTAssertNotEqual(try? mutableLeavesJSON!.prettyPrintedData(), testJSONData)
        XCTAssertNotEqual(try? allowFragmentsJSON!.prettyPrintedData(), testJSONData)
        XCTAssertEqual(try! rawInstalledJSON.prettyPrintedData(), testJSONData)
    }
    
    func testEquality() {
        XCTAssertEqual(mutableContainersJSON, mutableLeavesJSON)
        XCTAssertEqual(mutableLeavesJSON, allowFragmentsJSON)
        XCTAssertEqual(allowFragmentsJSON, rawInstalledJSON)
        XCTAssertEqual(rawInstalledJSON, mutableLeavesJSON)
        
        let json = MYJSON(rawValue: [" ":" "])
        XCTAssertNotEqual(mutableContainersJSON, json)
        XCTAssertNotEqual(mutableLeavesJSON, json)
        XCTAssertNotEqual(allowFragmentsJSON, json)
        XCTAssertNotEqual(rawInstalledJSON, json)
        XCTAssertEqual(json, MYJSON(rawValue: [" ":" "]))
    }
}
