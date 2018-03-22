//
//  ViewController.swift
//  Calculator
//
//  Created by Zhandos Bolatbekov on 2/20/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

func toString(_ value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.groupingSeparator = " "
    formatter.locale = Locale.current
    formatter.numberStyle = .decimal
    formatter.maximumSignificantDigits = 20
    return formatter.string(from: value as NSNumber)!
}

func toDouble(_ value: String) -> Double {
    return Double(value.components(separatedBy: [" ", "."]).joined())!
}

class ViewController: UIViewController {
    
    var firstNumber = 0.0
    var secondNumber = 0.0
    var operation = ""

    @IBOutlet weak var calculationLabel: UILabel!
    
    @IBAction func digitButtonPressed(_ sender: UIButton) {
        if(calculationLabel.text! == "0" || calculationLabel.text! == "Error") {
            calculationLabel.text! = sender.currentTitle!
        } else {
            calculationLabel.text! += sender.currentTitle!
        }
        calculationLabel.text! = toString(toDouble(calculationLabel.text!))
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        if calculationLabel.text! == "Error" {return}
        
        firstNumber = toDouble(calculationLabel.text!)
        calculationLabel.text! = "0"
        operation = sender.currentTitle!
    }
    
    @IBAction func resultButtonPressed(_ sender: UIButton) {
        if calculationLabel.text! == "Error" {return}
        
        secondNumber = toDouble(calculationLabel.text!)
        var result: Double?
        switch operation {
        case "%":
            result = firstNumber * secondNumber / 100.0
        case "/":
            if secondNumber == 0.0 {
                calculationLabel.text! = "Error"
            } else {
                result = firstNumber / secondNumber
            }
        case "x":
            result = firstNumber * secondNumber
        case "-":
            result = firstNumber - secondNumber
        case "+":
            result = firstNumber + secondNumber
        default:
            result = 0.0
        }
        
        if let result = result {
            calculationLabel.text! = toString(result)
        }
    }
    
    @IBAction func acButtonPressed(_ sender: UIButton) {
        calculationLabel.text! = "0"
        firstNumber = 0.0
        secondNumber = 0.0
        operation = ""
    }
    
    @IBAction func removeLastDigitButtonPressed(_ sender: UIButton) {
        if calculationLabel.text!.count == 1 {
            calculationLabel.text! = "0"
        } else {
            calculationLabel.text!.removeLast()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

