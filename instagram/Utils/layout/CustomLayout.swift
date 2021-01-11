//
//  CustomLayout.swift
//  instagram
//
//  Created by 张杰 on 2021/1/9.
//

import UIKit

class CustomLayout: UICollectionViewFlowLayout {
    static let notifyKey = "CustomLayoutPreper"
    
    override func prepare() {
        super.prepare()
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: CustomLayout.notifyKey),
            object: nil)
    }
}
