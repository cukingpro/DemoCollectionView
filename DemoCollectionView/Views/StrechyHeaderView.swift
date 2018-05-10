//
//  StrechyHeaderView.swift
//  DemoCollectionView
//
//  Created by Huy Tong N.H. on 5/9/18.
//  Copyright © 2018 Huy Tong N.H. All rights reserved.
//

import UIKit

class StrechyHeaderView: UICollectionReusableView {

    private var backgroundImageViewHeight: CGFloat = 0
    private var previousHeight: CGFloat = 0
        
    @IBOutlet weak var backgroundImageViewHeightLayoutContraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageViewHeight = backgroundImageView.bounds.height
    }

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes as! StrechyHeadersLayoutAttributes
        let height = attributes.frame.height
        if previousHeight != height {
            backgroundImageViewHeightLayoutContraint.constant = backgroundImageViewHeight - attributes.deltaY
            previousHeight = height
        }
    }
}
