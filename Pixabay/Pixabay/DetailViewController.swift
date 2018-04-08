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
    
    @IBAction func onPlayPauseButtonPressed(_ sender: UIButton) {
        isPlaying = !isPlaying
    }
    
    var url: URL!
    var isImage: Bool!
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
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resize
            videoView.layer.addSublayer(playerLayer)
            imageView.isHidden = true
        } else {
            playPauseButton.isHidden = true
            imageView.sd_setImage(with: url, completed: nil)
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
}
