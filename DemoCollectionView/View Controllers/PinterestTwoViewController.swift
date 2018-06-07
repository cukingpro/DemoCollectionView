//
//  PinterestTwoViewController.swift
//  DemoCollectionView
//
//  Created by Huy Tong N.H. on 6/7/18.
//  Copyright © 2018 Huy Tong N.H. All rights reserved.
//

import UIKit

class PinterestTwoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let colors: [UIColor] = [
        .red, .yellow, .green, .blue, .black
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }

    private func configureCollectionView() {
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! PinterestTwoLayout
        layout.delegate = self
    }
}

extension PinterestTwoViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pinterestCell", for: indexPath)
        let index = Int(arc4random_uniform(4))
        cell.backgroundColor = colors[index]
        return cell
    }
}

extension PinterestTwoViewController: PinterestTwoLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let random = arc4random_uniform(4) + 1
        return CGFloat(random * 100)
    }


}

