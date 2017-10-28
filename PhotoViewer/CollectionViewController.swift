//
//  CollectionViewController.swift
//  PhotoViewer
//
//  Created by jwilson on 10/16/17.
//  Copyright © 2017 jwilson. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    var photoArray: [Photo] = []
 
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchData()
    }
    
    func fetchData() {
        let url = URL(string: "https://api.flickr.com/services/rest/?format=json&sort=random&method=flickr.photos.search&tags=daffodil&tag_mode=all&api_key=0e2b6aaf8a6901c264acb91f151a3350&nojsoncallback=1")!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, err) in
            let data = data!
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            var tempPhotos: [[String: Any]] = []
            if let dictionary = json as? [String: Any]{
                if let newdictionary = dictionary["photos"] as? [String: Any] {
                    tempPhotos = newdictionary["photo"] as! [[String: Any]]!
                }
            }
                
            self.photoArray = tempPhotos.map{ Photo(dictionary: $0)}
            for photo in self.photoArray{
                print("\(photo.imageURL)")
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        task.resume()
    }
    
    
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        ImageService.shared.imageForURL(url: photoArray[indexPath.item].imageURL) { (image, url) in
            cell.imageView.image = image
            cell.photo = self.photoArray[indexPath.item]
        }
        return cell
    }
    
    
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        detailViewController.photo = photoArray[indexPath.item]
        present(detailViewController, animated: true, completion: nil)
        
    }
}

