//
//  DetailViewController.swift
//  Pixabay
//
//  Created by Zhandos Bolatbekov on 4/8/18.
//  Copyright © 2018 Zhandos Bolatbekov. All rights reserved.
//

import UIKit
import AVFoundation
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIBarButtonItem!
    
    @IBAction func onPlayPauseButtonPressed(_ sender: UIButton) {
        isPlaying = !isPlaying
    }
    @IBAction func onShareButtonPressed(_ sender: UIBarButtonItem) {
        let shareURL = URL(string: isImage ? self.image.webformatURL : self.video.mediumVideoURL)!
        let activityVC = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    @IBAction func onLikeButtonPressed(_ sender: UIBarButtonItem) {
        liked = true
        if(isImage) {
            Image.addToFavorites(image: self.image)
        } else {
            Video.addToFavorites(video: self.video)
        }
    }
    
    
    var image: Image!
    var video: Video!
    var isImage: Bool!
    var liked = false {
        didSet {
            if(liked) {
                likeButton.isEnabled = false
            } else {
                likeButton.isEnabled = true
            }
        }
    }
    var isPlaying = false {
        didSet {
            if(isPlaying) {
                playPauseButton.setBackgroundImage(#imageLiteral(resourceName: "pause"), for: .normal)
                player.play()
            } else {
                playPauseButton.setBackgroundImage(#imageLiteral(resourceName: "play"), for: .normal)
                player.pause()
            }
        }
    }
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(isImage == false) {
            imageView.isHidden = true
            playPauseButton.isHidden = false
            player = AVPlayer(url: URL(string: video.mediumVideoURL)!)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resize
            videoView.layer.addSublayer(playerLayer)
            if Storage.favoriteVideos.contains(video) {
                liked = true
            }
        } else {
            imageView.isHidden = false
            imageView.sd_setImage(with: URL(string: image.webformatURL)!, completed: nil)
            playPauseButton.isHidden = true
            imageView.isUserInteractionEnabled = true
            
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
            imageView.addGestureRecognizer(pinchGesture)
            if Storage.favoriteImages.contains(image) {
                liked = true
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(isImage == false) {
            isPlaying = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(isImage == false) {
            playerLayer.frame = videoView.bounds
        }
    }
    
    @objc func pinchGesture(sender: UIPinchGestureRecognizer) {
        print("pinch")
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1
    }
    
}
