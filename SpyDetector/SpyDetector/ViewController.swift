//
//  ViewController.swift
//  SpyDetector
//
//  Created by Zhandos Bolatbekov on 3/26/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftColorLabel: UILabel!
    @IBOutlet weak var rightColorLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    @IBAction func onNoButtonPressed(_ sender: UIButton) {
        statusImageView.isHidden = false
        if leftTitleIndex != rightColorIndex {
            statusImageView.image = #imageLiteral(resourceName: "success")
            totalScore += 20
        } else {
            statusImageView.image = #imageLiteral(resourceName: "fail")
            totalScore = max(0, totalScore - 5)
        }
        setupViews()
    }
    
    @IBAction func onYesButtonPressed(_ sender: UIButton) {
        statusImageView.isHidden = false
        if leftTitleIndex == rightColorIndex {
            statusImageView.image = #imageLiteral(resourceName: "success")
            totalScore += 20
        } else {
            statusImageView.image = #imageLiteral(resourceName: "fail")
            totalScore = max(0, totalScore - 5)
        }
        setupViews()
    }
    
    var timer = Timer()
    var timeLeft = 0 {
        didSet {
            timerLabel.text = String(format: "%02d:%02d", timeLeft / 60, timeLeft % 60)
        }
    }
    var leftColorIndex = 0
    var leftTitleIndex = 0
    var rightColorIndex = 0
    var rightTitleIndex = 0
    var totalScore = 0 {
        didSet {
            totalScoreLabel.text = "\(totalScore)"
        }
    }
    var colors = [UIColor.black, UIColor.green, UIColor.purple, UIColor.orange, UIColor.red, UIColor.yellow, UIColor.cyan, UIColor.brown]
    var titles = ["Black", "Green", "Purple", "Orange", "Red", "Yellow", "Cyan", "Brown"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftView.layer.cornerRadius = 8
        rightView.layer.cornerRadius = 8
        
        leftView.layer.shadowOpacity = 0.5
        leftView.layer.shadowOffset = CGSize(width: 0, height: 2)
        leftView.layer.shadowRadius = 10
        leftView.layer.shadowColor = UIColor.black.cgColor
        
        rightView.layer.shadowOpacity = 0.5
        rightView.layer.shadowOffset = CGSize(width: 0, height: 2)
        rightView.layer.shadowRadius = 10
        rightView.layer.shadowColor = UIColor.black.cgColor
        
        startNewGame()
    }
    
    func startNewGame() {
        setupViews()
        timeLeft = 10
        totalScore = 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(iteration), userInfo: nil, repeats: true)
    }
    
    func showResults() {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "Results") as! ResultsViewController
        self.present(newVC, animated: true, completion: nil)
    }
    
    func saveResults() {
        let defaults = UserDefaults.standard
        var array = defaults.array(forKey: "Results") as? [Int] ?? [Int]()
        array.append(totalScore)
        defaults.set(array, forKey: "Results")
    }
    
    func finishGame() {
        timer.invalidate()
        saveResults()
        let alert = UIAlertController(title: "Finish",
                                      message: "Your result is:\n\(totalScore) points", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Previous results", style: .default, handler: {action in
            self.showResults()
        }))
        alert.addAction(UIAlertAction(title: "Play again!", style: .default, handler: {action in
            self.startNewGame()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func iteration() {
        if(timeLeft > 0) {
            timeLeft -= 1
        } else {
            self.finishGame()
        }
    }

    func setupViews() {
        leftColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        leftTitleIndex = Int(arc4random_uniform(UInt32(titles.count)))
        
        rightColorIndex = Int(arc4random_uniform(UInt32(colors.count)))
        rightTitleIndex = Int(arc4random_uniform(UInt32(titles.count)))
        
        leftColorLabel.textColor = colors[leftColorIndex]
        leftColorLabel.text = titles[leftTitleIndex]
        
        rightColorLabel.textColor = colors[rightColorIndex]
        rightColorLabel.text = titles[rightTitleIndex]
    }
}

