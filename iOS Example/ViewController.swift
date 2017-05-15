//
//  ViewController.swift
//  iOS Example
//
//  Created by Optimus Prime on 14.05.17.
//  Copyright © 2017 Trenlab. All rights reserved.
//

import UIKit
import MYJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let _: [AccountTestClass] = AccountTestClass.self <- MYJSON(rawValue: TestJSON)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

