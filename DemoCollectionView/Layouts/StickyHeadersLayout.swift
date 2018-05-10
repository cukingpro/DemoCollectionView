//
//  StickyHeadersLayout.swift
//  DemoCollectionView
//
//  Created by Huy Tong N.H. on 5/10/18.
//  Copyright © 2018 Huy Tong N.H. All rights reserved.
//

import UIKit

class StickyHeadersLayout: UICollectionViewFlowLayout {

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = super.layoutAttributesForElements(in: rect)!
        let headerNeedingLayout = NSMutableIndexSet()
        for attributes in layoutAttributes where attributes.representedElementCategory == .cell {
            headerNeedingLayout.add(attributes.indexPath.section)
        }

        for attributes in layoutAttributes {
            if let elementKind = attributes.representedElementKind, elementKind == UICollectionElementKindSectionHeader {
                headerNeedingLayout.remove(attributes.indexPath.section)
            }
        }

        headerNeedingLayout.enumerate { (index, stop) in
            let indexpath = IndexPath(item: 0, section: index)
            let attributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexpath)!
            layoutAttributes.append(attributes)
        }

        for attributes in layoutAttributes {
            if let elementKind = attributes.representedElementKind, elementKind == UICollectionElementKindSectionHeader {
                let section = attributes.indexPath.section
                let attributesForFirstItemInSection = layoutAttributesForItem(at: IndexPath(item: 0, section: section))!
                let attributesForLastItemInSection = layoutAttributesForItem(at: IndexPath(item: collectionView!.numberOfItems(inSection: section) - 1, section: section))!

                var frame = attributes.frame
                let offset = collectionView!.contentOffset.y

                let minY = attributesForFirstItemInSection.frame.minY - frame.height
                let maxY = attributesForLastItemInSection.frame.maxY - frame.height

                let y = min(max(offset, minY), maxY)
                frame.origin.y = y
                attributes.frame = frame
                attributes.zIndex = 99
            }
        }

        return layoutAttributes
    }
}
