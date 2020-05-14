//
//  AddViewController.swift
//  Challenge7
//
//  Created by Ильдар Нигметзянов on 11.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    var notes: [Note]!
    
    @IBOutlet weak var textField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(closeController))
    }
    
    @objc func closeController(){
        
        self.notes.append(Note(text: textField.text))
        save()
        
        navigationController?.popViewController(animated: true)
    }
    
    func save(){
        let defaults = UserDefaults.standard
        
        let jsonEncoder = JSONEncoder()
        
        if let data = try? jsonEncoder.encode(notes){
            defaults.set(data, forKey: "Data")
        } else {
            fatalError("Could not to write data")
        }
    }
}
