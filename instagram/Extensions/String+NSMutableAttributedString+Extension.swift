//
//  String+NSMutableAttributedString+Extension.swift
//  instagram
//
//  Created by 张杰 on 2020/12/30.
//

import UIKit

extension String {
    func getAttributedString() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
}
