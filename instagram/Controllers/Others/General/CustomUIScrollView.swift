//
//  CustomUIScrollView.swift
//  instagram
//
//  Created by 张杰 on 2021/1/5.
//

import AVFoundation
import UIKit
import MJRefresh


class CustomUIScrollView: UIScrollView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomUIScrollView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func prints(y: CGFloat) {
        print("UIGestureRecognizerDelegate  \(y) ")
    }
}


