//
//  DetailViewController.swift
//  GORA Test API
//
//  Created by username on 19.01.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var photo: Photo!
    var downLoadTask: URLSessionDownloadTask?
    
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if photo != nil {
            updateUI()
        }
    }
    
    func updateUI() {
        imageTitleLabel.text = photo.title
        
        if let bigPhotoURL = URL(string: photo.url) {
            downLoadTask = bigImageView.loadImage(url: bigPhotoURL, indicator: loadIndicator)
        }
        bigImageView.layer.cornerRadius = 8
        bigImageView.clipsToBounds = true
    }
    
    deinit {
        downLoadTask?.cancel()
    }
}
