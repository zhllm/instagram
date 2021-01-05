//
//  Common.swift
//  instagram
//
//  Created by 张杰 on 2020/12/28.
//

import UIKit

let ZLMainScreenWeidth = UIScreen.main.bounds.size.width
let ZLMainScreenHeight = UIScreen.main.bounds.size.height


// MARK: - IphoneX
let ZL_iphoneX = (ZLMainScreenWeidth >= 375) && (ZLMainScreenHeight >= 812)

let ZL_statusBarHeight: CGFloat = ZL_iphoneX ? 44 : 20

let ZL_naviContentHeight: CGFloat = 44

let ZL_bottomTabBarContentHeight: CGFloat = 49

let ZL_bottomTabBarSpacing: CGFloat = ZL_iphoneX ? 34 : 0

let ZL_bottomTabBarHeight = ZL_iphoneX ? (ZL_bottomTabBarSpacing + ZL_naviContentHeight) : ZL_bottomTabBarContentHeight

let ZL_naviBarHeight: CGFloat = ZL_statusBarHeight + ZL_naviContentHeight
