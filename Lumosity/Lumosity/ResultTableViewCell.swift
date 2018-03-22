//
//  ResultTableViewCell.swift
//  Lumosity
//
//  Created by Zhandos Bolatbekov on 3/5/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var resultInfoLabel: UILabel!
    
    var result: ((right: Int, wrong: Int))! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        resultInfoLabel.text = "\(result.right)/\(result.wrong)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
