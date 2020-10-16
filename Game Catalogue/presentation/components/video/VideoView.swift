//
//  VideoView.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 17/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import SwiftUI
import AVFoundation
import AVKit

struct VideoView: UIViewRepresentable {
    
    var videoURL:URL
    var previewLength:Double?
    
    func makeUIView(context: Context) -> UIView {
        return PlayerView(frame: .zero, url: videoURL, previewLength: previewLength ?? 15)
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
