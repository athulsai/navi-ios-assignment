//
//  UIImageViewExtension.swift
//  NaviAssignment
//
//  Created by Athul Sai on 27/07/22.
//

import UIKit
import Foundation

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    @discardableResult
    func loadImageFromURL(urlString: String?, placeholder: UIImage? = nil) -> URLSessionDataTask? {
        self.image = nil

        guard let urlString = urlString else {
            self.image = placeholder
            return nil
        }


        let key = NSString(string: urlString)
        if let cachedImage = imageCache.object(forKey: key) {
            self.image = cachedImage
            return nil
        }

        guard let url = URL(string: urlString) else {
            return nil
        }

        if let placeholder = placeholder {
            self.image = placeholder
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                    self.image = downloadedImage
                }
            }
        }

        task.resume()
        return task
    }
}
