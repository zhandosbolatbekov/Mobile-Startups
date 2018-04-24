//
//  FavoritesViewController.swift
//  Pixabay
//
//  Created by Zhandos Bolatbekov on 4/11/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit

private struct Constants {
    static let detailSegue = "ShowDetail"
}

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    private var favoriteImages: [Image] = []
    private var favoriteVideos: [Video] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        
        favoriteImages = Storage.favoriteImages
        favoriteVideos = Storage.favoriteVideos
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.detailSegue:
            let dest = segue.destination as! DetailViewController
            let index = sender as! Int
            if (index < favoriteImages.count) {
                dest.isImage = true
                dest.image = self.favoriteImages[index]
            } else {
                dest.isImage = false
                dest.video = self.favoriteVideos[index - favoriteImages.count]
            }
            break
        default:
            return
        }
    }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2, height: self.view.frame.width / 2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteVideos.count + favoriteImages.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoritesCollectionViewCell
        let index = indexPath.item
        let url: URL
        if(index < favoriteImages.count) {
            url = URL(string: self.favoriteImages[index].previewURL)!
        } else {
            url = URL(string: self.favoriteVideos[index - favoriteImages.count].previewURL)!
        }
        print(url)
        cell.previewImageView.sd_setImage(with: url, completed: nil)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.detailSegue, sender: indexPath.item)
    }
}
