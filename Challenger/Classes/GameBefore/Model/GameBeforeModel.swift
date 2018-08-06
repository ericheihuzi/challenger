//
//  GameBeforeModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/4.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class GameBeforeModel: NSObject {
    //定义属性
    
    //用户的游戏属性
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
    @objc var userRanking: Int = 0
    
    //游戏属性
    /// 游戏名称
    @objc var gameTitle : String = ""
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
    /// 游戏主题色
    @objc var gameColor : String = ""
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
