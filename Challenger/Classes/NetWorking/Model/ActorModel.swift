//
//  ActorModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/27.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class ActorModel: NSObject {
    
    //定义属性：游戏参与者信息
    // - 用户ID
    @objc var userID: String = ""
    // - 游戏ID
    @objc var gameID: String = ""
    // - 脑力值
    @objc var score: Int = 0
    // - 段位
    @objc var grade: String = ""
    // - 地址
    @objc var location: String = ""
    // - 昵称
    @objc var nickName: String = ""
    // - 头像
    @objc var picName: String = ""
    // - 性别
    @objc var sex: Int = 0
    // - 日期
    @objc var date: String = ""
    // - 时间
    @objc var time: String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

