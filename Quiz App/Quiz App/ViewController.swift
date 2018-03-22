//
//  ViewController.swift
//  Quiz App
//
//  Created by Zhandos Bolatbekov on 2/17/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let questions = [Question(id: 1,
                              question: "Кто является создателем социальной сети Facebook?",
                              vars: ["mark", "bill", "ilon", "pavel"],
                              answer: "mark"),
                     Question(id: 2, question: "Какой мессенджер является самым популярным в мире?",
                              vars: ["telegram", "whatsapp", "facebook", "talk"],
                              answer: "whatsapp"),
                     Question(id: 3,
                              question: "Какой из предложенных логотипов принадлежит к файловому обменнику?",
                              vars: ["apple", "dropbox", "evernote", "huawei"],
                              answer: "dropbox"),
                     Question(id: 4,
                              question: "Какая марка автомобиля является самой популярной на 2018 год?",
                              vars: ["benz", "toyota", "honda", "bmw"],
                              answer: "toyota"),
                     Question(id: 5,
                              question: "Какой футбольный клуб стал победителем Лиги Чемпионов UEFA 2016-2017?",
                              vars: ["barca", "atletico", "madrid", "juventus"],
                              answer: "madrid")
    ]
    var qIndex = 0
    var correct = 0 {
        didSet {
            self.correctAnswersNumLabel.text = "Правильно: \(correct)"
        }
    }
    var incorrect = 0 {
        didSet {
            self.incorrectAnswersNumLabel.text = "Неправильно: \(incorrect)"
        }
    }
    var seconds = 0 {
        didSet {
            self.timerLabel.text = String(format: "%02d", seconds / 60) + String(format: ":%02d", seconds % 60)
        }
    }
    var timer = Timer()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionIdLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    
    @IBOutlet weak var varButton1: UIButton!
    @IBOutlet weak var varButton2: UIButton!
    @IBOutlet weak var varButton3: UIButton!
    @IBOutlet weak var varButton4: UIButton!
    @IBOutlet weak var submitAnswerButton: UIButton!
    @IBOutlet weak var correctAnswersNumLabel: UILabel!
    @IBOutlet weak var incorrectAnswersNumLabel: UILabel!
    
    func getQuestion() {
        self.questionIdLabel.text = "Вопрос \(qIndex + 1)"
        self.questionTextLabel.text = questions[qIndex].question
        self.varButton1.setBackgroundImage(UIImage(named: questions[qIndex].vars[0]),
                                           for: .normal)
        self.varButton2.setBackgroundImage(UIImage(named: questions[qIndex].vars[1]),
                                           for: .normal)
        self.varButton3.setBackgroundImage(UIImage(named: questions[qIndex].vars[2]),
                                           for: .normal)
        self.varButton4.setBackgroundImage(UIImage(named: questions[qIndex].vars[3]),
                                           for: .normal)
        self.submitAnswerButton.isEnabled = false
        self.submitAnswerButton.setTitle("Выберите вариант ответа", for: .normal)
    }
    
    func clear() {
        self.varButton1.layer.borderColor = UIColor.clear.cgColor
        self.varButton1.layer.borderWidth = 0
        self.varButton2.layer.borderColor = UIColor.clear.cgColor
        self.varButton2.layer.borderWidth = 0
        self.varButton3.layer.borderColor = UIColor.clear.cgColor
        self.varButton3.layer.borderWidth = 0
        self.varButton4.layer.borderColor = UIColor.clear.cgColor
        self.varButton4.layer.borderWidth = 0
        self.varButton1.isEnabled = true
        self.varButton2.isEnabled = true
        self.varButton3.isEnabled = true
        self.varButton4.isEnabled = true
    }
    
    @IBAction func varButtonPressed(_ sender: UIButton) {
        let curQuestion = questions[qIndex]
        let selectedIndex = sender.tag
        
        sender.layer.borderWidth = 3
        if curQuestion.vars[selectedIndex] == curQuestion.answer {
            sender.layer.borderColor = UIColor.green.cgColor
            correct += 1
        } else {
            sender.layer.borderColor = UIColor.red.cgColor
            incorrect += 1
        }
        self.varButton1.isEnabled = false
        self.varButton2.isEnabled = false
        self.varButton3.isEnabled = false
        self.varButton4.isEnabled = false
        self.submitAnswerButton.isEnabled = truese
        self.submitAnswerButton.setTitle("Продолжить", for: .normal)
    }
    
    @IBAction func submitAnswerButtonPressed(_ sender: UIButton) {
        if qIndex < questions.count - 1 {
            qIndex += 1
            getQuestion()
        } else {
            
            let newVC = self.storyboard?
                .instantiateViewController(withIdentifier: "FinishVC") as! SecondViewController
            newVC.seconds = self.seconds
            newVC.points = self.correct
            newVC.total = self.questions.count
            
            self.present(newVC, animated: true, completion: nil)
        }
        clear()
    }
    
    func startNewQuiz() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.seconds += 1
        })
        seconds = 0
        qIndex = 0
        correct = 0
        incorrect = 0
        getQuestion()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        varButton1.layer.cornerRadius = 8
        varButton1.layer.masksToBounds = true
        varButton2.layer.cornerRadius = 8
        varButton2.layer.masksToBounds = true
        varButton3.layer.cornerRadius = 8
        varButton3.layer.masksToBounds = true
        varButton4.layer.cornerRadius = 8
        varButton4.layer.masksToBounds = true
        
        startNewQuiz()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

