//
//  UserDataModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/2.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class UserDataModel: NSObject {
    //定义属性
    //1.登录状态
    var isLogin = Defaults[.isLogin]
    //2.账户属性
    // - 用户ID
    var userID: Int = 0
    // - 手机号
    var userPhoneNum: String = ""
    // - 密码
    var userPassword: String = ""
    // - 昵称
    var userNickName: String = ""
    // - 头像
    var userHeadImageURL: String = ""
    // - 性别
    var userSax: String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

