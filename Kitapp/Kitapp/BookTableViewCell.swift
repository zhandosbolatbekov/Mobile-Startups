//
//  BookTableViewCell.swift
//  Kitapp
//
//  Created by Zhandos Bolatbekov on 4/23/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookBackGroundView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var bookPagesLabel: UILabel!
    
    @IBAction func showBookInfoButtonPressed(_ sender: UIButton) {
        self.showBookInfoHandler?()
    }
    
    var showBookInfoHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let firstColor = UIColor.init(red: 248/255, green: 216/255, blue: 18/255, alpha: 1).cgColor
        let secondColor = UIColor.init(red: 239/255, green: 207/255, blue: 10/255, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bookBackGroundView.bounds
        gradientLayer.colors = [firstColor, secondColor]
        bookBackGroundView.layer.addSublayer(gradientLayer)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
