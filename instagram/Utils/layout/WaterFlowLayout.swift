//
//  WaterFlowLayout.swift
//  instagram
//
//  Created by 张杰 on 2021/1/3.
//

import UIKit
import MBProgressHUD

class WaterFlowLayout: UICollectionViewFlowLayout {
    var delegate: UICollectionViewDelegateFlowLayout?
    var attributes: [UICollectionViewLayoutAttributes] = []
    var xOffset: CGFloat = 0.0
    var yOffset: CGFloat = 0.0
    var countPerLine: Int = 3
    
    
    override func prepare() {
        super.prepare()
        attributes.removeAll()
        let itemCount = collectionView?.numberOfItems(inSection: 0)
        let sectionEdgeInset = self.delegate?.collectionView?(collectionView!, layout: self, insetForSectionAt: 0)
        xOffset = sectionEdgeInset!.left
        yOffset = sectionEdgeInset!.top
        
        let indexPath = IndexPath(item: 0, section: 0)
        let size = self.delegate?.collectionView?(collectionView!,
                                                  layout: self,
                                                  sizeForItemAt: indexPath)
        let count = ceilf(
            Float(
                (self.collectionView!.width - sectionEdgeInset!.left - sectionEdgeInset!.right + self.minimumInteritemSpacing) / (size!.width + self.minimumInteritemSpacing)
            )
        )
        countPerLine = Int(count)
        // debugPrint(countPerLine)
        var yHeights: [CGFloat] = []
        for i in 0..<itemCount! {
            let _indexPath = IndexPath(item: i, section: 0)
            let itemSize = self.delegate?.collectionView?(collectionView!, layout: self, sizeForItemAt: _indexPath)
            if (self.xOffset + itemSize!.width + sectionEdgeInset!.right - 1) <= collectionView!.width {
                let attribute = self.layoutAttributesForItem(at: _indexPath)
                if yHeights.count == countPerLine {
                    self.yOffset = yHeights[i % countPerLine] + self.minimumLineSpacing
                }
                attribute?.frame = CGRect(x: xOffset,
                                          y: yOffset,
                                          width: itemSize!.width,
                                          height: itemSize!.height).integral
                attributes.append(attribute!)
                self.xOffset = self.xOffset + itemSize!.width + self.minimumInteritemSpacing
                if yHeights.count < countPerLine {
                    yHeights.append(self.yOffset + itemSize!.height)
                } else {
                    yHeights[i % countPerLine] = self.yOffset + itemSize!.height
                }
            } else {
                self.xOffset = sectionEdgeInset!.left
                // debugPrint("i % countPerLine \(i % countPerLine) \(yHeights.count)")
                self.yOffset = yHeights[i % countPerLine] + self.minimumLineSpacing
                let attribute = layoutAttributesForItem(at: _indexPath)
                attribute!.frame = CGRect(x: xOffset,
                                          y: yOffset,
                                          width: itemSize!.width,
                                          height: itemSize!.height).integral
                attributes.append(attribute!)
                self.xOffset = self.xOffset + itemSize!.width + self.minimumInteritemSpacing
                yHeights[i % countPerLine] = self.yOffset + itemSize!.height
            }
        }
        
        for i in yHeights {
            yOffset = max(i, yOffset)
        }
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    override var collectionViewContentSize: CGSize{
        get {
            return CGSize(width: self.collectionView?.bounds.width ?? 0, height: yOffset + 4)
        }
    }
}
