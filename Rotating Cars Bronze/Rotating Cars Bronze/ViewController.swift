//
//  ViewController.swift
//  Rotating Cars Bronze
//
//  Created by Zhandos Bolatbekov on 2/13/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var fourthImageView: UIImageView!
    
    @IBOutlet weak var rotateCarsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rotateCarsButton.layer.cornerRadius = 20.0
    }
    
    @IBAction func rotateCarsButtonPressed(_ sender: UIButton) {
        
        let firstImage = firstImageView.image
        
        firstImageView.image = secondImageView.image
        secondImageView.image = thirdImageView.image
        thirdImageView.image = fourthImageView.image
        fourthImageView.image = firstImage
    }
}

