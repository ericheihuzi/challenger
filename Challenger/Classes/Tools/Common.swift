//
//  Common.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/6/28.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

//let kStatusBarH : CGFloat = 44
//let kNavigationBarH : CGFloat = 44
//let kTabbarH : CGFloat = 44

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

// 判断是否是iPhone X
//let iPhoneX = (max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.height) == 812.0 ? true : false)
let iPhoneX = (Double(kScreenW) == Double(375.0) && Double(kScreenH) == Double(812.0)) ? true : false


// 状态栏高度
let kStatusBarH : CGFloat = iPhoneX ? CGFloat(Double(44.0)) : CGFloat(Double(20.0))
// 导航栏高度
let kNavigationBarH : CGFloat = iPhoneX ? CGFloat(Double(44.0)) : CGFloat(Double(44.0))
// tabBar高度
let kTabbarH : CGFloat = iPhoneX ? CGFloat(Double(44.0)) : CGFloat(Double(20.0))
