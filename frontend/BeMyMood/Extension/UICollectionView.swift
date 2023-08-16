//
//  UICollectionView.swift
//  BeMyMood
//
//  Created by 송채영 on 2023/08/08.
//
import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}

class CenterAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let originalAttributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        var updatedAttributes: [UICollectionViewLayoutAttributes] = []
        var currentX: CGFloat = sectionInset.left
        let constantSpacing: CGFloat = 5 // 원하는 간격
        
        var rowAttributes: [UICollectionViewLayoutAttributes] = []
        var maxY: CGFloat = -1.0
        
        for (idx, val) in originalAttributes.enumerated() {
            let updatedAttribute = val.copy() as! UICollectionViewLayoutAttributes
            
            if updatedAttribute.frame.origin.y >= maxY {
                currentX = sectionInset.left
                rowAttributes.removeAll()
            }
            
            updatedAttribute.frame.origin.x = currentX
            rowAttributes.append(updatedAttribute)
            
            if idx < originalAttributes.count - 1 {
                let nextAttribute = originalAttributes[idx + 1]
                if nextAttribute.frame.origin.y > updatedAttribute.frame.origin.y {
                    alignRowCenter(rowAttributes: rowAttributes, totalWidth: collectionViewContentSize.width - sectionInset.left - sectionInset.right, constantSpacing: constantSpacing)
                }
            } else {
                alignRowCenter(rowAttributes: rowAttributes, totalWidth: collectionViewContentSize.width - sectionInset.left - sectionInset.right, constantSpacing: constantSpacing)
            }
            
            updatedAttributes.append(contentsOf: rowAttributes)
            
            currentX = rowAttributes.last?.frame.maxX ?? currentX
            maxY = max(updatedAttribute.frame.maxY, maxY)
        }
        
        return updatedAttributes
    }
    
    func alignRowCenter(rowAttributes: [UICollectionViewLayoutAttributes], totalWidth: CGFloat, constantSpacing: CGFloat) {
        let totalCellWidth = rowAttributes.reduce(0) { $0 + $1.frame.width }
        let totalSpacing = CGFloat(rowAttributes.count - 1) * constantSpacing
        let xOffset = (totalWidth - totalCellWidth - totalSpacing) / 2
        
        var currentX: CGFloat = sectionInset.left + xOffset
        for attribute in rowAttributes {
            attribute.frame.origin.x = currentX
            currentX += attribute.frame.width + constantSpacing
        }
    }
}

