//
//  DetailViewController.swift
//  PhotoViewer
//
//  Created by jwilson on 10/16/17.
//  Copyright © 2017 jwilson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var photo: Photo?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var photoName: UILabel!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoName.text = photo?.title
        ImageService.shared.imageForURL(url: photo?.imageURL) { (image, url) in
            self.imageView.image = image
        }
    }
    
}
