//
//  GameViewController.swift
//  EggToss
//
//  Created by Zhandos Bolatbekov on 4/24/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var eggImageView: UIImageView!
    @IBOutlet weak var brockenEggImageView: UIImageView!
    @IBOutlet weak var basketImageView: UIImageView!
    @IBOutlet weak var livesBackgroundView: UIView!
    @IBOutlet weak var gameOverView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var controlButtonsBackgroundView: UIView!
    
    @IBAction func changeBasketPosition(_ sender: UIButton) {
        basketPosition = sender.tag
    }
    
    @IBAction func onRestartButtonPressed(_ sender: UIButton) {
        restartGame()
    }
    
    var eggPosition = 0 {
        didSet {
            eggImageView.frame.origin.x = getEggPosition(index: eggPosition)
        }
    }
    var basketPosition = 1 {
        didSet {
            basketImageView.frame.origin.x = getBasketPosition(index: basketPosition)
        }
    }
    var timer = Timer()
    var lives = 5 {
        didSet {
            for case let (index, imageView as UIImageView) in
                livesBackgroundView.subviews.enumerated() {
                if(lives <= 4 - index) {
                    imageView.image = #imageLiteral(resourceName: "egg-broken")
                } else {
                    imageView.image = #imageLiteral(resourceName: "egg")
                }
            }
        }
    }
    var score = 0 {
        didSet {
            if(score > 0 && score % 5 == 0) {
                speed += 5
            }
        }
    }
    var speed = 15
    var isSuperEgg = false {
        didSet {
            if(isSuperEgg) {
                eggImageView.image = #imageLiteral(resourceName: "superegg")
            } else {
                eggImageView.image = #imageLiteral(resourceName: "egg-flying")
            }
        }
    }
    var level = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBasket()
        throwEgg()
    }
    
    private func setBasket() {
        switch level {
        case 0: basketImageView.frame.origin.y = 370
        case 1: basketImageView.frame.origin.y = 270
        case 2: basketImageView.frame.origin.y = 170
        default: basketImageView.frame.origin.y = 370
        }
    }
    
    private func getInitialPositionForEgg() {
        eggImageView.isHidden = false
        eggPosition = Int(arc4random_uniform(3))
        eggImageView.frame.origin.y = 0
    }
    
    private func generateEggType() {
        let rand = Int(arc4random_uniform(5))
        if(rand == 0) {
            isSuperEgg = true
        } else {
            isSuperEgg = false
        }
    }
    
    private func getEggPosition(index: Int) -> CGFloat {
        switch index {
        case 0: return 81
        case 1: return 174
        case 2: return 268
        default: return 174
        }
    }
    
    private func getBasketPosition(index: Int) -> CGFloat {
        switch index {
        case 0: return 26
        case 1: return 119
        case 2: return 214
        default: return 119
        }
    }
    
    func throwEgg() {
        if (lives > 0) {
            generateEggType()
            getInitialPositionForEgg()
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(changePosition), userInfo: nil, repeats: true)
        } else {
            gameOver()
        }
    }
    
    @objc func changePosition() {
        eggImageView.frame.origin.y += CGFloat(speed)
        checkEgg()
    }
    
    func checkEgg() {
        if(eggImageView.frame.origin.y >= basketImageView.frame.origin.y + 20) {
            if(eggImageView.frame.origin.y <= basketImageView.frame.origin.y + 100
                && basketPosition == eggPosition) {
                score += 1
                if(isSuperEgg && lives < 5) {
                    lives += 1
                }
                timer.invalidate()
                throwEgg()
            } else if(eggImageView.frame.origin.y > 500) {
                eggImageView.isHidden = true
                brockenEggImageView.isHidden = false
                brockenEggImageView.frame.origin.x = eggImageView.frame.origin.x - 10
                lives -= 1
                timer.invalidate()
                throwEgg()
            }
        }
    }
    
    func restartGame() {
        gameOverView.isHidden = true
        controlButtonsBackgroundView.isHidden = false
        brockenEggImageView.isHidden = true
        lives = 5
        score = 0
        basketPosition = 1
        throwEgg()
    }
    
    func gameOver() {
        gameOverView.isHidden = false
        controlButtonsBackgroundView.isHidden = true
        scoreLabel.text = "\(score)"
    }
}
