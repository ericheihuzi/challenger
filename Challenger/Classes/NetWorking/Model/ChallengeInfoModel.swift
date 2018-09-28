//
//  ChallengeInfoModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/7.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class ChallengeInfoModel: NSObject {
    
    //定义属性：用户综合游戏属性
    // - 用户ID
    @objc var userID: Int = 0
    // - 挑战次数
    @objc var challengeTime: Int = 0
    // - 排名变化
    @objc var rankingChange: Int = 0
    // - 世界排名
    @objc var worldRanking: Int = 0
    // - 用户综合分数
    @objc var score: Int = 0
    // - 用户段位
    @objc var grade: String = ""
    /// 用户雷达分
    @objc var rewscore : Int = 0
    @objc var cawscore : Int = 0
    @objc var inwscore : Int = 0
    @objc var mewscore : Int = 0
    @objc var spwscore : Int = 0
    @objc var crwscore : Int = 0
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

