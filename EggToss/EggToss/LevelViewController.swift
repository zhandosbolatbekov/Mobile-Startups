//
//  LevelViewController.swift
//  EggToss
//
//  Created by Zhandos Bolatbekov on 4/24/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

private struct Constants {
    static let startGameSegue = "StartGame"
}

class LevelViewController: UIViewController {

    @IBAction func levelChosen(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.startGameSegue, sender: sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.startGameSegue:
            let dest = segue.destination as! GameViewController
            let level = sender as! Int
            dest.level = level
        default:
            break
        }
    }
}
