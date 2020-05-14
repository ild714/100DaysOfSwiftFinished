//
//  DetailViewController.swift
//  Challenge1
//
//  Created by Ильдар Нигметзянов on 26.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    var nameOfImage = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image.image = UIImage(named:nameOfImage)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
    }
    
    @objc func share() {
        
        if let image = UIImage(named: nameOfImage)?.jpegData(compressionQuality: 0.8){
            let im = image
            let vc = UIActivityViewController(activityItems: [im,nameOfImage], applicationActivities: [])
            
            present(vc,animated: true)
        }
        
    }
    

}
