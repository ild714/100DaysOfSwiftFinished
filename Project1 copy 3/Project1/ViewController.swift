//
//  ViewController.swift
//  Project1
//
//  Created by Ильдар Нигметзянов on 14.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [Image]()
//    var amountOfTimes = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let data = defaults.data(forKey: "image"){
            let jsonDecoder = JSONDecoder()
            
            if let json = try? jsonDecoder.decode([Image].self, from: data){
                pictures = json
            }
        }
        
        let firstTime = defaults.bool(forKey: "First")
           
        if firstTime == false {
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(Image(times: 0, image: item))
            }
        }
            
            
//        pictures.sort()
        print(pictures)
        defaults.set(true, forKey: "First")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Picture",for:indexPath)
        cell.textLabel?.text = pictures[indexPath.row].image + " \(pictures[indexPath.row].times)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            self.pictures[indexPath.row].times += 1
            vc.selectedImage = pictures[indexPath.row].image
            vc.number = indexPath.row + 1
            vc.allAmount = pictures.count
            
            navigationController?.pushViewController(vc, animated: true)
            
            tableView.reloadData()
            self.save()
        }
    }
    
    func save() {
        let defaults = UserDefaults.standard
        
        let jsonDecoder = JSONEncoder()
        
        if let json = try? jsonDecoder.encode(pictures){
            defaults.set(json, forKey: "image")
        }
    }
}

