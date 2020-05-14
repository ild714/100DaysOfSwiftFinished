//
//  Person.swift
//  Project10_CollectionView
//
//  Created by Ильдар Нигметзянов on 17.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image:String){
        self.name = name
        self.image = image
    }
}
