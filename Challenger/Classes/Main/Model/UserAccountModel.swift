//
//  UserAccountModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/2.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class UserAccountModel: NSObject {
    //定义属性：用户账户属性
    //1.登录状态
    //@objc var isLogin = Defaults[.isLogin]
    //2.账户属性
    // - 用户ID
    @objc var userID: Int = 0
    // - 手机号
    @objc var userPhoneNum: String = ""
    // - 密码
    @objc var userPassword: String = ""
    // - 昵称
    @objc var userNickName: String = ""
    // - 头像
    @objc var userHeadImageURL: String = ""
    // - 性别
    @objc var userSex: String = ""
    // - 生日
    @objc var userBirthday: String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
//    convenience init(dict:Dictionary<String, Any>){
//        self.init()
//        let arr1 = ["用户ID","手机号","密码","昵称","头像","性别","生日"]
//        let arr2 = ["userID","userPhoneNum","userPassword","userNickName","userHeadImageURL","userSex","userBirthday"]
//        for (index, value) in arr1.enumerated() {
//            self.setValue(dict[value], forKey: arr2[index])
//        }
//    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

