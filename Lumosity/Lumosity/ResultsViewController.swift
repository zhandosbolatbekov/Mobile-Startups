//
//  ResultsViewController.swift
//  Lumosity
//
//  Created by Zhandos Bolatbekov on 3/5/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    typealias RESULT = (right: Int, wrong: Int)
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    private var results: [RESULT] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.object(forKey: "results") as? Data,
            let array = NSKeyedUnarchiver.unarchiveObject(with: data) as? [RESULT] {
            results = array
        }
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "Main") as! ViewController
        self.present(mainVC, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
