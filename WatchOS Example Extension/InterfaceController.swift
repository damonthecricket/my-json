//
//  InterfaceController.swift
//  WatchOS Example Extension
//
//  Created by Optimus Prime on 14.05.17.
//  Copyright © 2017 Trenlab. All rights reserved.
//

import WatchKit
import Foundation
import MYJSON

class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let _: [AccountTestClass] = AccountTestClass.self <- MYJSON(rawValue: TestJSON)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
