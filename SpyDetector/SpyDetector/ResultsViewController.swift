//
//  ResultsViewController.swift
//  SpyDetector
//
//  Created by Zhandos Bolatbekov on 3/30/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultsTableView: UITableView!
    
    private var results: [Int]!
    
    @IBAction func onPlayAgainButtonPressed(_ sender: UIButton) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "Main") as! ViewController
        self.present(mainVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let array = defaults.array(forKey: "Results") as? [Int] ?? [Int]()
        results = array
        results.sort{$0 > $1}

        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.rowHeight = UITableViewAutomaticDimension
        resultsTableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Result", for: indexPath) as! ResultTableViewCell
        cell.result = results[indexPath.row]
        return cell
    }
}
