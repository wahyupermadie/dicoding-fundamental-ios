//
//  ImageLoaderService.swift
//  Game Catalogue
//
//  Created by Wahyu Permadi on 13/10/20.
//  Copyright © 2020 Wahyu Permadi. All rights reserved.
//

import Foundation
import Combine
import UIKit

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<UIImage, Never>()
    var data = UIImage() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            DispatchQueue.main.async {
                self.data = cachedImage
            }
            return
        }

        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let downloadedImage = UIImage(data: data) else { return }
            
            ImageCache.shared.save(image: downloadedImage, forKey: urlString)
            
            DispatchQueue.main.async {
                self.data = downloadedImage
            }
        }
        task.resume()
    }
}

class ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol!

    static let shared = ImageCache()

    private init() {
        // make sure to purge cache on memory pressure

        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(observer)
    }

    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
