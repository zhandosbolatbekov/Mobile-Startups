//
//  BookInfoViewController.swift
//  Kitapp
//
//  Created by Zhandos Bolatbekov on 4/23/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit
import SDWebImage

class BookInfoViewController: UIViewController {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorsLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    
    var book: ViewController.OBJECT!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let volumeInfo = book["volumeInfo"] as? ViewController.OBJECT {
            bookTitleLabel.text = volumeInfo["title"] as? String
            bookDescriptionLabel.text = volumeInfo["description"] as? String
            if let imageLinks = volumeInfo["imageLinks"] as? ViewController.OBJECT {
                if let thumbnail = imageLinks["thumbnail"] as? String {
                    bookImageView.sd_setImage(with: URL(string: thumbnail)!, completed: nil)
                }
            }
            
            if let authors = volumeInfo["authors"] as? [String] {
                bookAuthorsLabel.text = "Authors: " + authors.joined(separator: ", ")
            }
        }
    }
}
