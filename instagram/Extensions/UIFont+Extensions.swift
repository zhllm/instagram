//
//  UIFont+Extensions.swift
//  instagram
//
//  Created by 张杰 on 2020/12/28.
//

import UIKit

enum FontType: String {
    case MontserratSemiBold = "Montserrat-SemiBold"
    case MontserratMedium = "Montserrat-Medium"
    case IconFont = "iconfont"
    case AvenirBook = "Avenir-Book"
}

extension UIFont {
    static func fit_screen_width(size: CGFloat) -> UIFont {
        if ZLMainScreenWeidth == 320 {
            return UIFont.systemFont(ofSize: size - 1)
        } else if ZLMainScreenWeidth == 375 {
            return UIFont.systemFont(ofSize: size)
        } else {
            return UIFont.systemFont(ofSize: size + 1)
        }
    }
    
    static func getRadioWidth(size: CGFloat) -> CGFloat {
        if ZLMainScreenWeidth == 320 {
            return size - 1
        } else if ZLMainScreenWeidth == 375 {
            return size
        } else {
            return size + 1
        }
    }
    
    static func getRadioHeight(size: CGFloat) -> CGFloat {
        return size / 667.0 * ZLMainScreenHeight
    }
    
    static func fit_screen_height(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: getRadioHeight(size: size))
    }
    
    static func customFont(family: FontType, size: CGFloat) -> UIFont {
        let font = UIFont.init(name: family.rawValue, size: getRadioWidth(size: size))
        if font == nil {
            return UIFont.systemFont(ofSize: getRadioWidth(size: size))
        }
        return font!
    }
}
