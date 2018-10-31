//
//  LevelModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/10/22.
//  Copyright © 2018 黑胡子. All rights reserved.
//

import UIKit

class LevelModel: NSObject {
    /// 当前等级
    @objc var level : Int = 0
    /// 当前间隔时间
    @objc var duration : Int = 0
    /// 当前回合
    @objc var round : Int = 0
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}


