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
    @IBAction func onShareButtonPressed(_ sender: UIBarButtonItem) {
        let activityVC = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
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
            imageView.isHidden = true
            playPauseButton.isHidden = false
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resize
            videoView.layer.addSublayer(playerLayer)
        } else {
            imageView.isHidden = false
            playPauseButton.isHidden = true
            imageView.sd_setImage(with: url, completed: nil)
            imageView.isUserInteractionEnabled = true
            
            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.pinchGesture))
            imageView.addGestureRecognizer(pinchGesture)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
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
