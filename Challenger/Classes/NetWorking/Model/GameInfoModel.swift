//
//  GameInfoModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/10.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class GameInfoModel: NSObject {
    
    //定义属性：单个游戏属性
    // 游戏ID
    @objc var gameID : String = ""
    /// 游戏名称
    @objc var title : String = "Title"
    /// 游戏icon
    @objc var iconName : String = ""
    /// 游戏封面图片对应的URLString
    @objc var coverName : String = ""
    /// 解锁类型
    @objc var price : Int = 0
    /// 挑战类型
    @objc var category : String = ""
    /// 参与人数
    @objc var join : Int = 0
    /// 游戏等级数量
    @objc var level : Int = 0
    /// 游戏关卡数量
    @objc var average : Int = 0
    /// 游戏主题色
    @objc var color : String = "##FFC643FB"
    /// 游戏雷达分值
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

