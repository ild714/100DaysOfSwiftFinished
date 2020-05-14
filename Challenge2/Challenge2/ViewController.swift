//
//  ViewController.swift
//  Challenge2
//
//  Created by Ильдар Нигметзянов on 04.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var products = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
    }

    @objc func add(){
        let ac =  UIAlertController(title: "Add your product", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let action = UIAlertAction(title: "Add", style: .default){[weak self,weak ac]
            (_) in
            if let text = ac?.textFields?[0].text {
                self?.products.insert(text, at: 0)
                
                let indexPath = IndexPath(row: 0, section: 0)
                self?.tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
        ac.addAction(action)
        present(ac,animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = products[indexPath.row]
        return cell
    }

}

