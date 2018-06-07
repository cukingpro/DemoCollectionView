//
//  StrechyHeadersLayout.swift
//  DemoCollectionView
//
//  Created by Huy Tong N.H. on 4/27/18.
//  Copyright © 2018 Huy Tong N.H. All rights reserved.
//

import UIKit

class StrechyHeadersLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var deltaY: CGFloat = 0

//    override func copy(with zone: NSZone? = nil) -> Any {
//        let copy = super.copy(with: zone) as! StrechyHeadersLayoutAttributes
//        copy.deltaY = deltaY
//        return copy
//    }
//
//    override func isEqual(_ object: Any?) -> Bool {
//        if let attributes = object as? StrechyHeadersLayoutAttributes {
//            if attributes.deltaY == deltaY {
//                return super.isEqual(object)
//            }
//        }
//        return false
//    }
}

class StrechyHeadersLayout: UICollectionViewFlowLayout {

    var maximunStretchHeight: CGFloat = 0

    override class var layoutAttributesClass: AnyClass {
        return StrechyHeadersLayoutAttributes.self
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect) as! [StrechyHeadersLayoutAttributes]
        let offset = collectionView!.contentOffset
        if offset.y < 0 {
            let deltaY = fabs(offset.y)
            for attributes in layoutAttributes {
                if let elementKind = attributes.representedElementKind, elementKind == UICollectionElementKindSectionHeader {
                    var frame = attributes.frame
                    frame.size.height = min(headerReferenceSize.height + deltaY, maximunStretchHeight)
                    frame.origin.y = frame.minY - deltaY
                    attributes.frame = frame
                    attributes.deltaY = deltaY
                }
            }
        }
        return layoutAttributes
    }

}
