//
//  JSONOperators.swift
//  InstaCollage
//
//  Created by Optimus Prime on 28.02.17.
//  Copyright © 2017 Tren Lab. All rights reserved.
//

import Foundation

// MARK: - Precedencegroup

precedencegroup DeserializingPrecedence {
    
    associativity: left
    
    higherThan: CastingPrecedence
}

// MARK: - Operators

/**
 Ifix operator. Used for MYJSON deserialization. 
 */
infix operator <-: DeserializingPrecedence
