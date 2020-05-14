//
//  DetailViewController.swift
//  Challenge5
//
//  Created by Ильдар Нигметзянов on 09.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    var city : String = ""
    var lon: Float = 0
    var lat: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label1.text = city
        label2.text = ("\(lat)")
        label3.text = ("\(lon)")
    }
    

   


}
