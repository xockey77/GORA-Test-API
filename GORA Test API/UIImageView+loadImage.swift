//
//  UIImageView+loadImage.swift
//  GORA Test API
//
//  Created by username on 19.01.2022.
//

import UIKit


extension UIImageView {
    func loadImage(url: URL, indicator: UIActivityIndicatorView) -> URLSessionDownloadTask {
        indicator.hidesWhenStopped  = true
        indicator.startAnimating()
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url) {
            [weak self] url, _, error in
            if error == nil, let url = url,
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let weakSelf = self {
                        weakSelf.image = image
                        indicator.stopAnimating()
                    }
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}
