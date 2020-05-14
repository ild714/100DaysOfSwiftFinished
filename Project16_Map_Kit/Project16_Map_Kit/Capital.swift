//
//  Capital.swift
//  Project16_Map_Kit
//
//  Created by Ильдар Нигметзянов on 09.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject,MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D,info: String){
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
