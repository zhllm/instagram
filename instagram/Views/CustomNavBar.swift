//
//  CustomNavBar.swift
//  instagram
//
//  Created by 张杰 on 2021/1/17.
//

import UIKit

let NavigationBarHeightIncrease: CGFloat = 128

class CustomNavBar: UINavigationBar {
    public weak var vcDelegate: HomeViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.transform = CGAffineTransform(translationX: 0, y: -NavigationBarHeightIncrease)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let isActive = vcDelegate?.navigationItem.searchController?.isActive else {
            return
        }
        
        if isActive {
            return
        }
        
        let height = NavigationBarHeightIncrease
        
        frame = CGRect(x: frame.origin.x, y:  0, width: frame.size.width, height: height)
        
        setTitleVerticalPositionAdjustment(10, for: UIBarMetrics.default)
        
        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarBackground") {
                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: height)
                subview.backgroundColor = .white
            }
            stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarContent") {
                subview.frame = CGRect(x: subview.frame.origin.x, y: 44, width: subview.frame.width, height: 84)
            }
            
            for subview2 in self.subviews {
                if NSStringFromClass(subview2.classForCoder).contains("SearchBar") {
                    subview2.frame = CGRect(
                        x: subview.frame.origin.x,
                        y: 84,
                        width: self.width,
                        height: 50.5
                    )
                    self.bringSubviewToFront(subview2)
                    break
                }
            }
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var superSize = super.sizeThatFits(size)
        superSize.height = NavigationBarHeightIncrease
        return superSize
    }
    
}
