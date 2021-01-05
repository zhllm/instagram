//
//  CustomUIScrollView.swift
//  instagram
//
//  Created by 张杰 on 2021/1/5.
//

import AVFoundation
import UIKit


class CustomUIScrollView: UIScrollView {
    private var headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.addSubview(headerView)
        headerView.frame = CGRect(x: self.left,
                                  y: self.top,
                                  width: self.width,
                                  height: 160)
        headerView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomUIScrollView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


