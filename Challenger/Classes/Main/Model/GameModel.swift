//
//  GameModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/10.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class GameModel: NSObject {
    //定义属性
    // 游戏ID
    var gameID : Int = 0
    /// 游戏封面图片对应的URLString
    var gameCover : String = ""
    /// 游戏背景图片对应的URLString
    var gameBackground : String = ""
    /// 游戏名称
    var gameTitle : String = ""
    /// 游戏等级
    var gameLevel : Int = 0
    /// 等级名称
    var levelTitle : String = ""
    /// 参与人数
    var peopleNum : Int = 0
    /// 解锁类型
    var gameUnlockType : String = ""
    /// 挑战类型
    var gameChallengeType : String = ""
    /// 游戏排名
    var gameRanking : Int = 0
    /// 游戏最大数值
    var gameMaxScore: [String: Int] = [
        "reasoningMS": 0,
        "calculationMS": 0,
        "inspectionMS": 0,
        "memoryMS": 0,
        "spaceMS": 0,
        "createMS": 0,
    ]
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

