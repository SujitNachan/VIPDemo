//
//  CustomImageView.swift
//  LoopNewMedia
//
//  Created by  on 31/10/22.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

class ImageViewWithCache:  UIImageView {
    
    var imageURLString: String?
    
    func loadImage(urlString: String?) {
        imageURLString = urlString
        if let urlString = urlString,
            let url = URL(string: urlString) {
            image = nil
            if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
                self.image = cachedImage
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("error")
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if let data = data {
                        let imageToCache = UIImage(data: data)
                        if self.imageURLString == urlString {
                            self.image = imageToCache
                        }
                        imageCache.setObject(imageCache, forKey: urlString as NSString)
                    }
                }
            }.resume()
        }
    }
}


