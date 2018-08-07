//
//  UserGameModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/2.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class UserGameModel: NSObject {
    //定义属性：用户单个游戏属性
    //用户ID
    @objc var userID : Int = 0
    // 游戏ID
    @objc var gameID : Int = 0
    /// 判断该游戏是否解锁
    // 0 : 未解锁 1 : 已解锁
    @objc var isUnclock : Int = 0
    // 最新分数
    @objc var userGameNewScore: Int = 0
    // 最高分数
    @objc var userGameMaxScore: Int = 0
    // 当前挑战等级
    @objc var userGameLevel: Int = 0
    // 维度分数
    @objc var userGameRadarScore: [String: Int] = [
        "reasoning": 124,
        "calculation": 156,
        "inspection": 140,
        "memory": 163,
        "space": 145,
        "create": 108,
        ]
    // 游戏排名
    var userRanking: Int = 0
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
