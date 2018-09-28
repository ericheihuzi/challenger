//
//  ChallengeLog.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/27.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class ChallengeLogModel: NSObject {
    
    //定义属性：挑战记录
    // - gameID
    @objc var gameID: String = ""
    // - 脑力值
    @objc var score: Int = 0
    // - 时间
    @objc var time: String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
