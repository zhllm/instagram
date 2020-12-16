//
//  UIview+Extensions.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import UIKit

extension UIView {
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    
    public var bottom: CGFloat {
        return self.frame.origin.y + self.height
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.origin.x + self.width
    }
}
