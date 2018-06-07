//
//  PinterestTwoLayout.swift
//  DemoCollectionView
//
//  Created by Huy Tong N.H. on 6/7/18.
//  Copyright © 2018 Huy Tong N.H. All rights reserved.
//

import UIKit

protocol PinterestTwoLayoutDelegate: class {

    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class PinterestTwoLayout: UICollectionViewLayout {

    var numberOfColumns: Int = 2
    var cellPadding: CGFloat = 3
    var delegate: PinterestTwoLayoutDelegate!

    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var width: CGFloat {
        let inset = collectionView!.contentInset
        return collectionView!.bounds.width - (inset.left + inset.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: width, height: contentHeight)
    }

    override func prepare() {
        guard cache.isEmpty else {
            return
        }

        let columnWidth = width / CGFloat(numberOfColumns)

        var xOffsets = [CGFloat]()
        for column in 0..<numberOfColumns {
            xOffsets.append(CGFloat(column) * columnWidth)
        }

        var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)

        var column = 0
        for item in 0..<collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)

            let width = columnWidth
            let height = delegate.collectionView(collectionView: collectionView!, heightForPhotoAtIndexPath: indexPath)

            let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: width, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            contentHeight = max(contentHeight, frame.maxY)
            yOffsets[column] = yOffsets[column] + height
            column = column >= (numberOfColumns - 1) ? 0 : (column + 1)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}
