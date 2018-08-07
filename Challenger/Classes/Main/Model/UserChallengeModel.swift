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
    @objc var userID: Int = Defaults[.userID]
    // - 挑战次数
    @objc var challengeNum: String = Defaults[.challengeNum]!
    // - 排名变化
    @objc var rankingChange: String = Defaults[.rankingChange]!
    // - 世界排名
    @objc var userWorldRanking: String = Defaults[.userWorldRanking]!
    // - 用户综合分数
    @objc var userScore: String = Defaults[.userScore]!
    // - 用户段位
    @objc var userGrade: String = Defaults[.userGrade]!
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

