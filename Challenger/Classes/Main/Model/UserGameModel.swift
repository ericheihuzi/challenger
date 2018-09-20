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
    @objc var ispay : Int = 0
    // 最新分数
    @objc var newscore: Int = 0
    // 最高分数
    @objc var maxscore: Int = 0
    // 当前挑战等级
    @objc var level: Int = 0
    // 游戏排名
    var ranking: Int = 0
    // 排名变化
    var rankingChange: Int = 0
    /// 游戏雷达分
    @objc var rescore : Int = 0
    @objc var cascore : Int = 0
    @objc var inscore : Int = 0
    @objc var mescore : Int = 0
    @objc var spscore : Int = 0
    @objc var crscore : Int = 0
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
