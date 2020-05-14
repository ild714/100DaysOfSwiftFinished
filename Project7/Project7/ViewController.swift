//
//  ViewController.swift
//  Project7
//
//  Created by Ильдар Нигметзянов on 05.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var sortedPetitions = [Petition]()
    var showSort = false
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showSort == true{
            return sortedPetitions.count
        }else {
            return petitions.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if showSort == true {
            let petition = sortedPetitions[indexPath.row]
            cell.textLabel?.text = petition.title
            cell.detailTextLabel?.text = petition.body
        }else {
            let petition = petitions[indexPath.row]
            cell.textLabel?.text = petition.title
            cell.detailTextLabel?.text = petition.body
        }
        return cell
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString : String
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Information", style: .plain, target: self, action: #selector(showInfo))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort petition", style: .plain, target: self, action: #selector(sortPetition))
        
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    @objc func showInfo(){
        let ac = UIAlertController(title: "The source of data", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(ac,animated: true)
    }
    
    @objc func sortPetition(){
        let ac = UIAlertController(title: "Write the part of petiton text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let textField = UIAlertAction(title: "Find petitions", style: .default) { [weak self,weak ac](_) in
            if let text = ac?.textFields?[0].text {
                for i in 0..<self!.petitions.count {
                    if self?.petitions[i].title.lowercased().contains(text.lowercased()) ?? false {
                        self?.sortedPetitions.append(self?.petitions[i] ?? Petition(title: "Test", body: "Test", signatureCount: 0))
                    }
                }
            }
            self?.showSort = true
            self?.tableView.reloadData()
        }
        
        let showOriginal = UIAlertAction(title: "Show original", style: .default) { [weak self](_) in
            self?.showSort = false
            self?.sortedPetitions.removeAll()
            self?.tableView.reloadData()
        }
        
        ac.addAction(textField)
        ac.addAction(showOriginal)
        present(ac,animated: true)
    }
    
    func showError(){
        let ac = UIAlertController(title: "Loading error", message: "There was a problem with connections", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac,animated: true)
    }
    
    func parse(json:Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self,from: json){
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

