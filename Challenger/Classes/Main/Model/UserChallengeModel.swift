//
//  UserChallengeModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/7.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class UserChallengeModel: NSObject {
    //定义属性：用户综合游戏属性
    
    // - 用户ID
    @objc var userID: Int = 0
    // - 挑战次数
    @objc var challengeNum: Int = 0
    // - 排名变化
    @objc var rankingChange: Int = 0
    // - 世界排名
    @objc var userWorldRanking: Int = 0
    // - 用户综合分数
    @objc var userScore: Int = 0
    // - 用户段位
    @objc var userGrade: String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

