//
//  LocalGameModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/10/17.
//  Copyright © 2018 黑胡子. All rights reserved.
//

import UIKit

class LocalGameModel: NSObject {
    
    //定义属性：单个游戏属性
    // 游戏ID
    @objc var gameID : String = ""
    /// 游戏名称
    @objc var title : String = "Title"
    /// 平均分
    @objc var average : Int = 0
    /// 游戏等级数量
    @objc var level : Int = 0
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

