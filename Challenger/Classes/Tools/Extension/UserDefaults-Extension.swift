//
//  UserDefaults-Extension.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/29.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    //登录信息
    static let isLogin = DefaultsKey<Bool>("isLogin")
    static let token = DefaultsKey<String?>("token")
    static let userID = DefaultsKey<Int>("userID")
    
    // 用户信息
    static let nickName = DefaultsKey<String?>("nickName")
    static let phoneNum = DefaultsKey<String?>("phoneNum")
    static let userHeadImage = DefaultsKey<String?>("userHeadImage")
    
    static let launchCount = DefaultsKey<Int>("launchCount")
}
