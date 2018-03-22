//
//  FirstViewController.swift
//  Taro
//
//  Created by Zhandos Bolatbekov on 2/19/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var professionButton: UIButton!
    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var salaryButton: UIButton!
    
    @IBAction func categoryChosen(_ sender: UIButton) {
        performSegue(withIdentifier: "SecondVC", sender: sender.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tag = sender as! Int
        let dest = segue.destination as! ViewController
        switch tag {
            case 0:
                dest.category = "Profession"
            case 1:
                dest.category = "Car"
            case 2:
                dest.category = "Salary"
            default:
                dest.category = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        professionButton.layer.borderColor = UIColor.white.cgColor
        professionButton.layer.borderWidth = 2
        carButton.layer.borderColor = UIColor.white.cgColor
        carButton.layer.borderWidth = 2
        salaryButton.layer.borderColor = UIColor.white.cgColor
        salaryButton.layer.borderWidth = 2
    }
}
