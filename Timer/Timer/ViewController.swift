//
//  ViewController.swift
//  Timer
//
//  Created by Zhandos Bolatbekov on 2/14/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    var timer = Timer()
    var seconds = 0 {
        didSet {
            timeLabel.text = String(format: "%02d", seconds / 60)
                + String(format: ":%02d", seconds % 60)
        }
    }
    var timerIsRunning = false {
        didSet {
            if (timerIsRunning && seconds > 0) {
                startPauseButton.setTitle("Pause", for: .normal)
                timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(ViewController.increment), userInfo: nil, repeats: true)
            } else {
                startPauseButton.setTitle("Start", for: .normal)
                timer.invalidate()
            }
        }
    }
    
    @IBAction func startPauseButtonPressed(_ sender: UIButton) {
        timerIsRunning = !timerIsRunning
    }
    
    @IBAction func restartButtonPressed(_ sender: UIButton) {
        timerIsRunning = false
        startPauseButton.isHidden = false
        seconds = 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seconds = 60
    }
    
    @objc func increment() {
        if seconds > 0 {
            seconds -= 1
        } else {
            timerIsRunning = false
            startPauseButton.isHidden = true
        }
    }
}

