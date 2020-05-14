//
//  ViewController.swift
//  Project18_Debugging
//
//  Created by Ильдар Нигметзянов on 10.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        assert(1 == 1, "failere")
        
        for i in 1...100{
            print("Got number \(i)")
        }
    }


}

