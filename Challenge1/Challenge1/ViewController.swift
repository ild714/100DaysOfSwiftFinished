//
//  ViewController.swift
//  Challenge1
//
//  Created by Ильдар Нигметзянов on 26.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var flags = ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.imageView?.image = UIImage(named:flags[indexPath.row])
        
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController{
            vc.nameOfImage = flags[indexPath.row]
            
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

