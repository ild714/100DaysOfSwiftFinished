//
//  ViewController.swift
//  Challenge5
//
//  Created by Ильдар Нигметзянов on 09.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var country: Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://ip-api.com/json/24.48.0.1")!
        
        let jsonDecoder = JSONDecoder()
        
        guard let data = try? Data(contentsOf: url) else {return}
        
        if let clearData = try? jsonDecoder.decode(Country.self, from: data){
            self.country = Country(country: clearData.country, city: clearData.city, lat: clearData.lat, lon: clearData.lon)
        }else {
            print("error")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = country.country
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let st = storyboard?.instantiateViewController(identifier: "Detail") as! DetailViewController
        st.city = country.city
        st.lat = country.lat
        st.lon = country.lon
        
        navigationController?.pushViewController(st, animated: true)
    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        cell.textLabel?.text = country.country
//
//        return cell
//    }
}

