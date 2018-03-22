//
//  Question.swift
//  Quiz App
//
//  Created by Zhandos Bolatbekov on 2/17/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import Foundation
import UIKit

struct Question {
    var id = 0
    var question = ""
    var vars = [String]()
    var answer = ""
    
    init(id: Int, question: String, vars: [String], answer: String) {
        self.id = id
        self.question = question
        self.vars = vars
        self.answer = answer
    }
}
