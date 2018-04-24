//
//  ViewController.swift
//  Kitapp
//
//  Created by Zhandos Bolatbekov on 4/22/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
import UIScrollView_InfiniteScroll

private struct Constants {
    static let bookCell = "Book Cell"
    static let bookInfoSegue = "ShowBookInfo"
    static let blockSize = 5
}

class ViewController: UIViewController {
    
    typealias OBJECT = [String: Any]
    
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var booksTableView: UITableView!
    @IBOutlet private weak var nothingFoundImageView: UIImageView!
    
    @IBAction func onSearchButtonPressed(_ sender: UIButton) {
        if ((searchTextField.text?.count)! > 0) {
            performAnimation()
            getBooks(bookTitle: searchTextField.text!)
        }
    }
    
    private var books = [OBJECT]()
    private var storage = [OBJECT]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        searchTextField.layer.cornerRadius = 8
        searchTextField.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        searchTextField.delegate = self
        searchButton.layer.cornerRadius = 8
        
        booksTableView.delegate = self
        booksTableView.dataSource = self
        booksTableView.tableFooterView = UIView()
        booksTableView.addInfiniteScroll { (tableView) in
            self.books.append(contentsOf: self.getNextBlock(from: self.books.count))
            tableView.reloadData()
            tableView.finishInfiniteScroll()
        }
        booksTableView.infiniteScrollTriggerOffset = 1500
        booksTableView.setShouldShowInfiniteScrollHandler { _ in self.storage.count > self.books.count }
        booksTableView.beginInfiniteScroll(true)
    }
    
    private func getNextBlock(from startIndex: Int) -> [OBJECT] {
        let bound = min(startIndex + Constants.blockSize, self.storage.count)
        return Array(self.storage[startIndex..<bound])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBooks(bookTitle: String) {
        let stringURL = "https://www.googleapis.com/books/v1/volumes?q=\(bookTitle.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)"
        guard let url = URL(string: stringURL) else {return}
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if((error) != nil) {
                print(error!.localizedDescription)
            } else {
                let json = JSON(data)
                if let items = json["items"].arrayObject {
                    self.storage = items as! [OBJECT]
                    self.books = self.getNextBlock(from: 0)
                    print(self.storage.count)
                } else {
                    self.storage = []
                    self.books = []
                }
                DispatchQueue.main.async {
                    self.booksTableView.reloadData()
                    self.nothingFoundImageView.isHidden = (self.books.count > 0)
                }
            }
        }
        task.resume()
    }
    
    func performAnimation() {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.5) {
            self.searchButton.isHidden = true
            self.logoImageView.isHidden = true
            self.booksTableView.isHidden = false
            self.searchTextField.frame.origin.y = 84
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.bookInfoSegue:
            let dest = segue.destination as! BookInfoViewController
            let index = sender as! Int
            dest.book = self.books[index]
        default:
            break
        }
    }
}


extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.shadowColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        textField.layer.shadowOpacity = 0.2
        textField.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        textField.layer.shadowRadius = 5
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.shadowOpacity = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if ((textField.text?.count)! > 0) {
            performAnimation()
            getBooks(bookTitle: textField.text!)
        }
        return true
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.bookCell,
                                                 for: indexPath) as! BookTableViewCell
        if let volumeInfo = self.books[indexPath.row]["volumeInfo"] as? OBJECT {
            cell.bookTitleLabel.text = volumeInfo["title"] as? String
            cell.bookDescriptionLabel.text = volumeInfo["description"] as? String
            if let pageCount = volumeInfo["pageCount"] as? Int {
                cell.bookPagesLabel.text = "\(pageCount) pages"
            } else {
                cell.bookPagesLabel.text = ""
            }
            if let imageLinks = volumeInfo["imageLinks"] as? OBJECT {
                if let thumbnail = imageLinks["thumbnail"] as? String {
                    cell.bookImageView.sd_setImage(with: URL(string: thumbnail)!, completed: nil)
                }
            }
            cell.showBookInfoHandler = {
                self.performSegue(withIdentifier: Constants.bookInfoSegue, sender: indexPath.row)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
}


extension UIViewController {
    func hideKeyboard() {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
}

