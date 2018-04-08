//
//  ResultTableViewCell.swift
//  SpyDetector
//
//  Created by Zhandos Bolatbekov on 3/30/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var result = 0 {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        resultLabel.text = "\(result) pts."
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
