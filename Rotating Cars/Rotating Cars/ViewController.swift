//
//  ViewController.swift
//  Rotating Cars
//
//  Created by Zhandos Bolatbekov on 2/13/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstCar: UIImageView!
    @IBOutlet weak var secondCar: UIImageView!
    @IBOutlet weak var thirdCar: UIImageView!
    @IBOutlet weak var fourthCar: UIImageView!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(rotateCars), userInfo: nil, repeats: true)
    }
    
    @objc func rotateCars() {
        swap(&firstCar.image, &secondCar.image)
        swap(&secondCar.image, &thirdCar.image)
        swap(&thirdCar.image, &fourthCar.image)
    }
}

