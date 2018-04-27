//
//  StrechyHeadersLayout.swift
//  DemoCollectionView
//
//  Created by Huy Tong N.H. on 4/27/18.
//  Copyright © 2018 Huy Tong N.H. All rights reserved.
//

import UIKit

class StrechyHeadersLayout: UICollectionViewFlowLayout {

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)!
        let offset = collectionView!.contentOffset
        if offset.y < 0 {
            let deltaY = fabs(offset.y)
            for attributes in layoutAttributes {
                if let elementKind = attributes.representedElementKind, elementKind == UICollectionElementKindSectionHeader {
                    var frame = attributes.frame
                    frame.size.height = headerReferenceSize.height + deltaY
                    frame.origin.y = frame.minY - deltaY
                    attributes.frame = frame
                }
            }
        }
        return layoutAttributes
    }

}
