//
//  CollectionViewCell.swift
//  DemoCollectionView
//
//  Created by Huy Tong N.H. on 4/16/18.
//  Copyright © 2018 Huy Tong N.H. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!

    @IBOutlet weak var captionLabel: UILabel!

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes as! PinterestLayoutAttributes
        imageViewHeightLayoutConstraint.constant = attributes.photoHeight
    }
}
