//
//  ViewController.swift
//  MacOS Example
//
//  Created by Optimus Prime on 14.05.17.
//  Copyright © 2017 Trenlab. All rights reserved.
//

import Cocoa
import MYJSON

class ViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let _: [AccountTestClass] = AccountTestClass.self <- MYJSON(rawValue: TestJSON)
    }
}

