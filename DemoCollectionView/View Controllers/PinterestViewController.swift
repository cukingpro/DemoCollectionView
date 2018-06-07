//
//  PinterestViewController.swift
//  DemoCollectionView
//
//  Created by Huy Tong N.H. on 4/9/18.
//  Copyright © 2018 Huy Tong N.H. All rights reserved.
//

import UIKit
import AVFoundation

class PinterestViewController: UIViewController {

    var photos = { () -> [UIImage] in
        var photos = [UIImage]()
        for i in 1...10 {
            photos.append(UIImage(named: String(i))!)
        }
        return photos
    }()

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpCollectionView()
    }

    private func setUpCollectionView() {
        let layout = collectionView.collectionViewLayout as! PinterestLayout
        layout.delegate = self
        layout.numberOfColumns = 2
    }

}

extension PinterestViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = photos[indexPath.row]
        return cell
    }
}

extension PinterestViewController: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let photo = photos[indexPath.row]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude)
        let rect = AVMakeRect(aspectRatio: photo.size, insideRect: boundingRect)
        return rect.height
    }
}
