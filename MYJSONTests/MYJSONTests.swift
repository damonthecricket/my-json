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

        
        mutableContainersJSON = try? JSONSerialization.mutableContainersJSON(with: testJSONData)

        mutableLeavesJSON = try? JSONSerialization.mutableLeavesJSON(with: testJSONData)
        
        allowFragmentsJSON = try? JSONSerialization.allowFragmentsJSON(with: testJSONData)
        
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
            
            XCTAssertNotNil(mutableContainersJSON!.dictionary)
            XCTAssertNotNil(mutableLeavesJSON!.dictionary)
            XCTAssertNotNil(allowFragmentsJSON!.dictionary)
            XCTAssertNotNil(rawInstalledJSON.dictionary)
            
            XCTAssertNil(mutableContainersJSON!.array)
            XCTAssertNil(mutableLeavesJSON!.array)
            XCTAssertNil(allowFragmentsJSON!.array)
            XCTAssertNil(rawInstalledJSON.array)

            let convertedTestJSON: MYJSONType = testJSON as! MYJSONType

            XCTAssertTrue((mutableContainersJSON!.rawValue as! MYJSONType) == convertedTestJSON)
            XCTAssertTrue((mutableLeavesJSON!.rawValue as! MYJSONType) == convertedTestJSON)
            XCTAssertTrue((allowFragmentsJSON!.rawValue as! MYJSONType) == convertedTestJSON)
            XCTAssertTrue((rawInstalledJSON.rawValue as! MYJSONType) == convertedTestJSON)
            
            XCTAssertTrue(mutableContainersJSON!.dictionary! == convertedTestJSON)
            XCTAssertTrue(mutableLeavesJSON!.dictionary! == convertedTestJSON)
            XCTAssertTrue(allowFragmentsJSON!.dictionary! == convertedTestJSON)
            XCTAssertTrue(rawInstalledJSON!.dictionary! == convertedTestJSON)
            
            XCTAssertTrue(mutableContainersJSON!.dictionary! == (mutableContainersJSON!.rawValue as! MYJSONType))
            XCTAssertTrue(mutableLeavesJSON!.dictionary! == (mutableLeavesJSON!.rawValue as! MYJSONType))
            XCTAssertTrue(allowFragmentsJSON!.dictionary! == (allowFragmentsJSON!.rawValue as! MYJSONType))
            XCTAssertTrue(rawInstalledJSON!.dictionary! == (rawInstalledJSON.rawValue as! MYJSONType))
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
            
            XCTAssertNil(mutableContainersJSON!.dictionary)
            XCTAssertNil(mutableLeavesJSON!.dictionary)
            XCTAssertNil(allowFragmentsJSON!.dictionary)
            XCTAssertNil(rawInstalledJSON.dictionary)
            
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
        XCTAssertNotEqual(try? JSONSerialization.prettyPrintedData(withJSON: mutableContainersJSON!), testJSONData)
        XCTAssertNotEqual(try? JSONSerialization.prettyPrintedData(withJSON: mutableLeavesJSON!), testJSONData)
        XCTAssertNotEqual(try? JSONSerialization.prettyPrintedData(withJSON: allowFragmentsJSON!), testJSONData)
        XCTAssertEqual(try! JSONSerialization.prettyPrintedData(withJSON: rawInstalledJSON), testJSONData)
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
