//
//  ViewController.swift
//  Chellange4
//
//  Created by Ильдар Нигметзянов on 07.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var allImages = classImages()
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let jsonEncoder = JSONDecoder()
        
        if let data = defaults.data(forKey: "Data")
        {
            if let clearData = try? jsonEncoder.decode([Images].self, from: data){
                self.allImages.images = clearData
            }
        }
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let jsonEncoder = JSONDecoder()
        
        if let data = defaults.data(forKey: "Data")
        {
            if let clearData = try? jsonEncoder.decode([Images].self, from: data){
                self.allImages.images = clearData
            }
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pickImage))
    }
    
    @objc func pickImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[.editedImage] as? UIImage {
            let images = Images(id: UUID(), label: "Fill")
            let filename = getDocumentDirectory().appendingPathComponent("\(images.id)")
            
            let data = image.jpegData(compressionQuality: 0.8)
            do {
                try data?.write(to: filename)
                allImages.images.append(images)
                self.save()
            } catch {
                print("error writing image")
            }
            
        }
        
        
        print("ok")
        
        tableView.reloadData()
        dismiss(animated: true)
        
    }
    
    func save(){
        let defaults = UserDefaults.standard
        
        let jsonEncoder = JSONEncoder()
        
        if let data = try? jsonEncoder.encode(allImages.images){
            defaults.set(data, forKey: "Data")
        }
    }
    
    func getDocumentDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allImages.images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        do{
            let filename = getDocumentDirectory().appendingPathComponent("\(allImages.images[indexPath.row].id)")
            let savedData = try Data(contentsOf: filename)
            cell.images.image = UIImage(data: savedData)
            cell.label.text = allImages.images[indexPath.row].label
        } catch {
            print("Unable to read the file")
        }
        
//        cell.images.image = allImages[indexPath.row].
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let st = storyboard?.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        st.imageId = allImages.images[indexPath.row].id
        st.textDetail = indexPath.row
        
        st.allImagesClass = self.allImages
        
        navigationController?.pushViewController(st, animated: true)
    }
    

}

