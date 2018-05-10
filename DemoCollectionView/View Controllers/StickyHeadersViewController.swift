//
//  StickyHeadersViewController.swift
//  DemoCollectionView
//
//  Created by Huy Tong N.H. on 5/10/18.
//  Copyright © 2018 Huy Tong N.H. All rights reserved.
//

import UIKit

class StickyHeadersViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
    }

}

extension StickyHeadersViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StickyHeaderCell", for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "StickyHeader", for: indexPath)
        return header

    }
}
