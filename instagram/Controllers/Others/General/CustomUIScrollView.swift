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
//    private var headerView: UIView = {
//        let view = UIView()
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
//        self.addSubview(headerView)
//        headerView.frame = CGRect(x: self.left,
//                                  y: 0,
//                                  width: self.width,
//                                  height: 220)
//        headerView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomUIScrollView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        guard let delegate = self.delegate as? CameraViewController else {
//            return true
//        }
//        let offset = delegate.collectionView.contentOffset
//        let size = delegate.collectionView.contentSize
//        
//        prints(y: offset.y)
//        prints(y: self.height)
//        prints(y: size.height)
//        print(offset.y + self.height >= size.height)
//        
//        if offset.y + self.height >= size.height {
//            return false
//        }
        return true
    }
    
    func prints(y: CGFloat) {
        print("UIGestureRecognizerDelegate  \(y) ")
    }
}


