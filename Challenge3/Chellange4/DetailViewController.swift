//
//  DetailViewController.swift
//  Chellange4
//
//  Created by Ильдар Нигметзянов on 08.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var imageId: UUID = UUID()
    var textDetail = 0
    
    var allImagesClass = classImages()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var detailPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            let filename = getDocumentDirectory().appendingPathComponent("\(allImagesClass.images[textDetail].id)")
            let savedData = try Data(contentsOf: filename)
            detailPhoto.image = UIImage(data: savedData)
//            textField.text = ("\(self.textDetail)")
            
        } catch {
            print("error")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        update()
    }
    
    func update() {
        print(textField.text!)
        allImagesClass.images[textDetail].label = textField.text!
        save()
    }
    
    func getDocumentDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save(){
        let defaults = UserDefaults.standard
        
        let jsonEncoder = JSONEncoder()
        
        if let data = try? jsonEncoder.encode(allImagesClass.images){
            defaults.set(data, forKey: "Data")
        }
    }
}
