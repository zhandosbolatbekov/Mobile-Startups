//
//  ViewController.swift
//  Pixabay
//
//  Created by Zhandos Bolatbekov on 4/6/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import AVKit

private struct Constants {
    static let blueColor = UIColor.init(red: 122/255, green: 137/255, blue: 1, alpha: 1)
    static let detailSegue = "ShowDetail"
    static let favoritesSegue = "ShowFavorites"
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imagesButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    
    @IBAction func imagesButtonClicked(_ sender: UIButton) {
        isSearchImages = true
        imagesButton.backgroundColor = Constants.blueColor
        imagesButton.setTitleColor(UIColor.white, for: .normal)
        videoButton.backgroundColor = UIColor.white
        videoButton.setTitleColor(Constants.blueColor, for: .normal)
        
        if(currentQuery != "") {
            getData(query: currentQuery)
        }
    }
    
    @IBAction func videoButtonClicked(_ sender: UIButton) {
        isSearchImages = false
        videoButton.backgroundColor = Constants.blueColor
        videoButton.setTitleColor(UIColor.white, for: .normal)
        imagesButton.backgroundColor = UIColor.white
        imagesButton.setTitleColor(Constants.blueColor, for: .normal)
        
        if(currentQuery != "") {
            getData(query: currentQuery)
        }
    }
    
    private var images: [Image] = []
    private var videos: [Video] = []
    private var isSearchImages = true 
    private var currentQuery = ""
    
    func getData(query: String) {
        print(query)
        self.images = []
        self.videos = []
        if(isSearchImages) {
            Image.search(query: query) { images in
                self.images = images
                self.collectionView.reloadData()
            }
        } else {
            Video.search(query: query) { videos in
                self.videos = videos
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesButton.layer.borderColor = Constants.blueColor.cgColor
        imagesButton.layer.borderWidth = 1
        videoButton.layer.borderColor = Constants.blueColor.cgColor
        videoButton.layer.borderWidth = 1
        
        let searchController = UISearchController(searchResultsController: nil)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.detailSegue:
            let dest = segue.destination as! DetailViewController
            let index = sender as! Int
            if (isSearchImages) {
                dest.isImage = true
                dest.image = self.images[index]
            } else {
                dest.isImage = false
                dest.video = self.videos[index]
            }
            break
        case Constants.favoritesSegue:
            break
        default:
            return
        }
    }
}

extension ViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
        
        let trimmedString = searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(trimmedString != "") {
            self.currentQuery = trimmedString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            getData(query: self.currentQuery)
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (isSearchImages) {
            return self.images.count
        }
        return self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! CustomImageCollectionViewCell
        let url: URL
        if(isSearchImages) {
            url = URL(string: self.images[indexPath.item].previewURL)!
        } else {
            url = URL(string: self.videos[indexPath.item].previewURL)!
        }
        print(url)
        cell.previewImageView.sd_setImage(with: url, completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.detailSegue, sender: indexPath.item)
    }
}

