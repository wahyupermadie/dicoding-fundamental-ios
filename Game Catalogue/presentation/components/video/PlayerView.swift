//
//  PlayerView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 17/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PlayerView: UIView {

    private let playerLayer = AVPlayerLayer()
    private var previewTimer:Timer?
    var previewLength:Double
    
    init(frame: CGRect, url: URL, previewLength:Double) {
        self.previewLength = previewLength
        super.init(frame: frame)
        
        // Create the video player using the URL passed in.
        let player = AVPlayer(url: url)
        player.volume = 0 // Will play audio if you don't set to zero
        player.play() // Set to play once created
        
        // Add the player to our Player Layer
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill // Resizes content to fill whole video layer.
        playerLayer.backgroundColor = UIColor.black.cgColor
        
        previewTimer = Timer.scheduledTimer(withTimeInterval: previewLength, repeats: true, block: { (timer) in
            player.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(1)))
        })
        

        layer.addSublayer(playerLayer)
    }
    
    required init?(coder: NSCoder) {
        self.previewLength = 15
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
