//
//  ViewController.swift
//  Lumosity
//
//  Created by Zhandos Bolatbekov on 3/4/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var totalRightLabel: UILabel!
    @IBOutlet weak var totalWrongLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    let colors = [UIColor.black, UIColor.blue, UIColor.brown, UIColor.green, UIColor.orange, UIColor.purple, UIColor.red, UIColor.white, UIColor.yellow]
    let colorTitles = ["BLACK", "BLUE", "BROWN", "GREEN", "ORANGE", "PURPLE", "RED", "WHITE", "YELLOW"]
    
    var leftColorIndex = 0
    var leftTitleIndex = 0
    var rightColorIndex = 0
    var rightTitleIndex = 0
    var totalRight = 0 {
        didSet {
            totalRightLabel.text = "\(totalRight)"
        }
    }
    var totalWrong = 0 {
        didSet {
            totalWrongLabel.text = "\(totalWrong)"
        }
    }
    var timer = Timer()
    var seconds = 0 {
        didSet {
            timeLabel.text = "TIME: " + String(format: "%02d:%02d", seconds / 60, seconds % 60)
        }
    }
    var timerRunning = false {
        didSet {
            if timerRunning {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer),
                                             userInfo: nil, repeats: true)
            } else {
                timer.invalidate()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftLabel.layer.shadowRadius = 6
        leftLabel.layer.shadowOpacity = 1
        
        rightLabel.layer.shadowRadius = 6
        rightLabel.layer.shadowOpacity = 1
        
        startNewGame()
    }
    
    func startNewGame() {
        setupViews()
        seconds = 5
        timerRunning = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isLightColor(color: UIColor) -> Bool {
        return (color == .white || color == .yellow || color == .green)
    }
    
    func setupViews() {
        
        leftColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        leftTitleIndex = Int(arc4random_uniform(UInt32(colors.count)))
        
        rightColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        rightTitleIndex = Int(arc4random_uniform(UInt32(colors.count)))
        
        leftLabel.text = colorTitles[leftTitleIndex]
        leftLabel.backgroundColor = colors[leftColorIndex]
        if isLightColor(color: leftLabel.backgroundColor!) {
            leftLabel.textColor = .black
        } else {
            leftLabel.textColor = .white
        }
        
        rightLabel.text = colorTitles[rightTitleIndex]
        rightLabel.backgroundColor = colors[rightColorIndex]
        if isLightColor(color: rightLabel.backgroundColor!) {
            rightLabel.textColor = .black
        } else {
            rightLabel.textColor = .white
        }
    }
    
    func showResults() {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "Results") as! ResultsViewController
        self.present(newVC, animated: true, completion: nil)
    }
    
    func saveResults() {
        if let results = UserDefaults.standard.object(forKey: "results") as? [ResultsViewController.RESULT] {
            var array = results
            array.append((right: totalRight, wrong: totalWrong))
            let encoded = NSKeyedArchiver.archivedData(withRootObject: array)
            UserDefaults.standard.set(encoded, forKey: "results")
        } else {
            let encoded = NSKeyedArchiver.archivedData(withRootObject: [(right: totalRight, wrong: totalWrong)])
            UserDefaults.standard.set(encoded, forKey: "results")
        }
        UserDefaults.standard.synchronize()
    }
    
    @objc func updateTimer() {
        
        seconds -= 1
        if seconds == 0 {
            timerRunning = false
            saveResults()
            
            let message = "Your results:\n \(totalRight) right answers\n \(totalWrong) wrong answers"
            let alert = UIAlertController(title: "Time is up!", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Play again",
                                          style: .default,
                                          handler: {(action: UIAlertAction!) in self.startNewGame()}))
            
            alert.addAction(UIAlertAction(title: "Show previous results",
                                          style: .default,
                                          handler: {(action: UIAlertAction!) in self.showResults()}))
            
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func yesButtonPressed(_ sender: UIButton) {
        if leftTitleIndex == rightColorIndex {
            statusImage.image = #imageLiteral(resourceName: "right")
            totalRight += 1
        } else {
            statusImage.image = #imageLiteral(resourceName: "wrong")
            totalWrong += 1
        }
        setupViews()
    }
    
    @IBAction func noButtonPressed(_ sender: UIButton) {
        if leftTitleIndex != rightColorIndex {
            statusImage.image = #imageLiteral(resourceName: "right")
            totalRight += 1
        } else {
            statusImage.image = #imageLiteral(resourceName: "wrong")
            totalWrong += 1
        }
        setupViews()
    }
}

