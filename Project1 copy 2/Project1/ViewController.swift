//
//  ViewController.swift
//  Project1
//
//  Created by Ильдар Нигметзянов on 14.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
            }
        }
        pictures.sort()
        print(pictures)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath) as? CollectionCell else {
           fatalError("Unable to dequeue PersonCell.")
        }
        
        
        cell.image.image = UIImage(named:pictures[indexPath.row])
        cell.label.text = pictures[indexPath.row]
        
        cell.image.layer.borderWidth = 1
        cell.image.layer.cornerRadius = 3
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let st = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            st.selectedImage = pictures[indexPath.row]
            st.number = indexPath.row + 1
            st.allAmount = pictures.count
            navigationController?.pushViewController(st, animated: true)
        }
        
    }
}

