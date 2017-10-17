//
//  Photo.swift
//  PhotoViewer
//
//  Created by jwilson on 10/16/17.
//  Copyright © 2017 jwilson. All rights reserved.
//

import Foundation
struct Photo {
    let title: String
    let imageURL: URL
    
    
    init(title: String, imageURL: URL) {
        self.title = title
        self.imageURL = imageURL
    }
    init(dictionary: [String:Any]){
        let id = dictionary["id"] as! String
        let secret = dictionary["secret"] as! String
        let server = dictionary["server"] as! String
        let farm = dictionary["farm"] as! Int
        let title = dictionary["title"] as! String
        let imageURLString = "https://farm" + String(farm) + ".static.flickr.com/" + server + "/" + id + "_" + secret + ".jpg"
        let imageURL = URL(string: imageURLString)
        
        self.init(title: title, imageURL: imageURL!)
    }
}
