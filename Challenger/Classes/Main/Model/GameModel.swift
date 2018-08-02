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
    @objc var gameID : Int = 0
    /// 游戏名称
    @objc var gameTitle : String = "555"
    /// 游戏icon
    @objc var gameIconURL : String = ""
    /// 游戏封面图片对应的URLString
    @objc var gameCoverURL : String = ""
    /// 解锁类型
    @objc var gameUnlockType : String = ""
    /// 挑战类型
    @objc var gameChallengeType : String = ""
    /// 参与人数
    @objc var peopleNum : Int = 0
    /// 游戏等级数量
    @objc var gameLevelCount : Int = 0
    /// 游戏雷达分
    @objc var gameRadarScore: [String: Int] = [
        "reasoningRS": 0,
        "calculationRS": 0,
        "inspectionRS": 0,
        "memoryRS": 0,
        "spaceRS": 0,
        "createRS": 0,
    ]
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

