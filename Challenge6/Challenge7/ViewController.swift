//
//  ViewController.swift
//  Challenge7
//
//  Created by Ильдар Нигметзянов on 11.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.reloadData()
        
        let defaults = UserDefaults.standard
        
        if let data = defaults.data(forKey: "Data"){
            let jsonDecoder = JSONDecoder()
            notes = try! jsonDecoder.decode([Note].self, from: data) 
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
    }

    @objc func addNote(){
        let st = storyboard?.instantiateViewController(identifier: "Add") as! AddViewController
        st.notes = notes
        
        navigationController?.pushViewController(st, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = notes[indexPath.row].text
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let st = storyboard?.instantiateViewController(identifier: "Detail") as! DetailViewController
        st.index = indexPath.row
        st.notes = notes
        
        navigationController?.pushViewController(st, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let defaults = UserDefaults.standard
        
        if let data = defaults.data(forKey: "Data"){
            let jsonDecoder = JSONDecoder()
            notes = try! jsonDecoder.decode([Note].self, from: data)
        }
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
}

