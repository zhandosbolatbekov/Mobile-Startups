//
//  Car.swift
//  Taro
//
//  Created by Zhandos Bolatbekov on 2/20/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation

struct Car {
 
    var id = 0
    var name = ""
    var imgName = ""
    
    init(id: Int, name: String, imgName: String) {
        self.id = id
        self.name = name
        self.imgName = imgName
    }
}
