//
//  WorldRankingModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/8.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class WorldRankingModel: NSObject {
    //定义属性
    //排名
    @objc var rankingTag : Int = 0
    // 用户ID
    @objc var userID : Int = 0
    /// 排名变化
    @objc var rankingChange : Int = 0
    // 用户头像
    @objc var headImageURL: String = ""
    // 用户昵称
    @objc var userNickName: String = ""
    // 分数
    @objc var userMaxScore: Int = 0
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
