//
//  ViewController.swift
//  Taro
//
//  Created by Zhandos Bolatbekov on 2/19/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

struct Constants {
    static let professions = [Profession(id: 1, name: "Актер", imgName: "actor"),
                              Profession(id: 2, name: "Адвокат", imgName: "advokat"),
                              Profession(id: 3, name: "Агроном", imgName: "agronom"),
                              Profession(id: 4, name: "Архитектор", imgName: "architector"),
                              Profession(id: 5, name: "Астроном", imgName: "astronom"),
                              Profession(id: 6, name: "Авто-механик", imgName: "auto-mechanic"),
                              Profession(id: 7, name: "Авиа-инженер", imgName: "avia-engineer"),
                              Profession(id: 8, name: "Банкир", imgName: "bankir"),
                              Profession(id: 9, name: "Биолог", imgName: "biolog"),
                              Profession(id: 10, name: "Повар", imgName: "cook"),
                              Profession(id: 11, name: "Врач", imgName: "doctor"),
                              Profession(id: 12, name: "Геолог", imgName: "geolog"),
                              Profession(id: 13, name: "Хирург", imgName: "hirurg"),
                              Profession(id: 14, name: "Полиция", imgName: "police"),
                              Profession(id: 15, name: "Программист", imgName: "programmer"),
                              Profession(id: 16, name: "Учитель", imgName: "teacher")
    ]
    static let cars = [Car(id: 1, name: "Audi", imgName: "audi"),
                       Car(id: 2, name: "Mercedec-Benz", imgName: "benz"),
                       Car(id: 3, name: "BMW", imgName: "bmw"),
                       Car(id: 4, name: "Chrysler", imgName: "chrysler"),
                       Car(id: 5, name: "Ferrari", imgName: "ferrari"),
                       Car(id: 6, name: "Honda", imgName: "honda"),
                       Car(id: 7, name: "Infinity", imgName: "infinity"),
                       Car(id: 8, name: "Koenigsegg", imgName: "koenigsegg"),
                       Car(id: 9, name: "Lamborghini", imgName: "lambo"),
                       Car(id: 10, name: "Lexus", imgName: "lexus"),
                       Car(id: 11, name: "Mitsubishi", imgName: "mitsubishi"),
                       Car(id: 12, name: "Priora", imgName: "priora"),
                       Car(id: 13, name: "Range-Rover", imgName: "range-rover"),
                       Car(id: 14, name: "Rolls-Royce", imgName: "rolls-royce"),
                       Car(id: 15, name: "Toyota", imgName: "toyota"),
                       Car(id: 16, name: "Wolksvagen", imgName: "wolks")
    ]
    static let salaries = ["1000 $",
                           "5 $",
                           "78787 $",
                           "1000000 $",
                           "777 $",
                           "990 $",
                           "12345 $"
    ]
}

class ViewController: UIViewController {

    @IBOutlet weak var categoryDescLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var predictionName: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var salaryLabel: UILabel!
    
    var timer = Timer()
    var index = 0
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startPauseButton.layer.borderWidth = 2
        startPauseButton.layer.borderColor = UIColor.white.cgColor
        startPauseButton.setTitle("СТАРТ", for: .normal)
     
        predictionName.text = ""
        switch category {
        case "Profession":
            imgView.isHidden = false
            salaryLabel.isHidden = true
            categoryDescLabel.text = "Моя будущая профессия"
        case "Car":
            imgView.isHidden = false
            salaryLabel.isHidden = true
            categoryDescLabel.text = "Моя будущая машина"
        case "Salary":
            imgView.isHidden = true
            salaryLabel.isHidden = false
            predictionName.text = ""
            categoryDescLabel.text = "Моя будущая зарплата"
        default:
            categoryDescLabel.text = ""
        }
    }
    
    @IBAction func startPauseBtnPressed(_ sender: UIButton) {
        if startPauseButton.currentTitle == "СТАРТ" {
            startPauseButton.setTitle("СТОП", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changePrediction), userInfo: nil, repeats: true)
        } else {
            startPauseButton.setTitle("СТАРТ", for: .normal)
            timer.invalidate()
        }
    }
    
    @objc func changePrediction() {
        switch category {
        case "Profession":
            index = (index + 1) % Constants.professions.count
            let prof = Constants.professions[index]
            predictionName.text = prof.name
            imgView.image = UIImage(named: prof.imgName);
        case "Car":
            index = (index + 1) % Constants.cars.count
            let car = Constants.cars[index]
            predictionName.text = car.name
            imgView.image = UIImage(named: car.imgName);
        case "Salary":
            index = (index + 1) % Constants.salaries.count
            let salary = Constants.salaries[index]
            salaryLabel.text = salary
        default:
            print("default")
        }
    }
}

