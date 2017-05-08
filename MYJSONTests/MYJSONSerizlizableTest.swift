//
//  MYJSONSerizlizableTest.swift
//  MYJSON
//
//  Created by Optimus Prime on 08.05.17.
//  Copyright © 2017 Trenlab. All rights reserved.
//

import XCTest
@testable import MYJSON

class MYJSONSerizlizableTest: XCTestCase {
    
    var testJSON: MYJSON = MYJSON(rawValue: TestJSON)
    
    // MARK: - Serialization
    
    func testSerialization() {
        let prettyPrintedData = try? JSONSerialization.prettyPrintedData(withJSON: testJSON)
        let data = try? JSONSerialization.data(withJSON: testJSON, options: [JSONSerialization.WritingOptions.prettyPrinted])
        
        XCTAssertEqual(prettyPrintedData, data)
        
        let rawData: Data?
        switch testJSON {
        case .value(let json):
            rawData = try? JSONSerialization.data(withJSONObject: json, options: [JSONSerialization.WritingOptions.prettyPrinted])
        case .array(let jsonArray):
            rawData = try? JSONSerialization.data(withJSONObject: jsonArray, options: [JSONSerialization.WritingOptions.prettyPrinted])
        }
        
        XCTAssertEqual(rawData, data)
        XCTAssertEqual(rawData, prettyPrintedData)
        XCTAssertEqual(rawData, try? testJSON.prettyPrintedData())
    }
}
