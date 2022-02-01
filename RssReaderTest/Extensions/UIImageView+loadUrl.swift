//
//  UIImageView+loadUrl.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 01.02.2022.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCache(withUrl url: URL) {
        let urlString = url.absoluteString
        self.image = nil

        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        let activityIndicator = UIActivityIndicatorView(style: .medium)
        addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        activityIndicator.center = self.center

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }
        }).resume()
    }
}
