//
//  SecondViewController.swift
//  Quiz App
//
//  Created by Zhandos Bolatbekov on 2/18/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var startNewQuizButton: UIButton!
   
    var seconds: Int!
    var points: Int!
    var total: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewQuizButton.layer.cornerRadius = 8
        resultTextLabel.text = "Правильных ответов: \(points!) из \(total!)\n"
            + "За время: \(seconds / 60) минут, \(seconds % 60) секунд"
    }

    @IBAction func startNewQuizBtnPressed(_ sender: Any) {
        let mainVC = self.storyboard?
            .instantiateViewController(withIdentifier: "MainVC") as! ViewController
        self.present(mainVC, animated: true, completion: nil)
    }
}
