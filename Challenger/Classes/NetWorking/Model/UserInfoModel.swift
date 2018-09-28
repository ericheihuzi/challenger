//
//  UserInfoModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/5.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class UserInfoModel: NSObject {
    
    //定义属性：用户信息
    // - token
    @objc var token: String = ""
    // - 用户ID
    @objc var userID: String = ""
    // - 手机号
    @objc var phone: String = ""
    // - 地址
    @objc var location: String = ""
    // - 昵称
    @objc var nickName: String = ""
    // - 头像
    @objc var picName: String = ""
    // - 性别
    @objc var sex: Int = 0
    // - 生日
    @objc var birthday: String = ""
    // - 年龄
    @objc var age: Int = 0
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

