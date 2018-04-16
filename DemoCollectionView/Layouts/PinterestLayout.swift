//
//  PinterestLayout.swift
//  DemoCollectionView
//
//  Created by Huy Tong N.H. on 4/16/18.
//  Copyright © 2018 Huy Tong N.H. All rights reserved.
//

import UIKit
import AVFoundation

protocol PinterestLayoutDelegate: class {

    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat

    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {

    var photoHeight: CGFloat = 0

    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! PinterestLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }

    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? PinterestLayoutAttributes {
            if attributes.photoHeight == photoHeight {
                return true
            }
        }
        return false
    }

}

class PinterestLayout: UICollectionViewLayout {

    var delegate: PinterestLayoutDelegate!
    var numberOfColumns: Int = 1
    var cellPadding: CGFloat = 3

    private var cache = [PinterestLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var width: CGFloat {
        let inset = collectionView!.contentInset
        return collectionView!.bounds.width - (inset.left + inset.right)
    }

    override class var layoutAttributesClass: AnyClass {
        return PinterestLayoutAttributes.self
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

            let width = columnWidth - 2 * cellPadding
            let photoHeight = delegate.collectionView(collectionView: collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
            let annotationHeight = delegate.collectionView(collectionView: collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
            let height = photoHeight + annotationHeight + cellPadding * 2

            let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            let attributes = PinterestLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            attributes.photoHeight = photoHeight
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
