//
//  UserDefaults-Extension.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/29.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    //登录信息
    static let isLogin = DefaultsKey<Bool>("isLogin") //登录状态
    static let token = DefaultsKey<String?>("token") //token
    static let userID = DefaultsKey<Int>("userID") //用户ID
    
    // 用户信息
    static let userNickName = DefaultsKey<String?>("userNickName") //昵称
    static let userPhoneNum = DefaultsKey<String?>("userPhoneNum") //手机号
    static let userPassword = DefaultsKey<String?>("userPassword") //密码
    static let userHeadImageURL = DefaultsKey<String?>("userHeadImageURL") //头像
    static let userSax = DefaultsKey<String?>("userSax") //性别
    static let userBirthday = DefaultsKey<String?>("userBirthday") //生日
    
    //用户游戏信息
    static let challengeNum = DefaultsKey<String?>("challengeNum") //挑战次数
    static let rankingChange = DefaultsKey<String?>("rankingChange") //今日排名变化
    static let userWorldRanking = DefaultsKey<String?>("userRanking") //世界排名
    static let userScore = DefaultsKey<String?>("userScore") //用户综合分数
    static let userGrade = DefaultsKey<String?>("userGrade") //用户段位
    
    static let launchCount = DefaultsKey<Int>("launchCount")
    
    //图表属性
    static let chartViewDataColor = DefaultsKey<String?>("chartViewDataColor") //雷达图主题色
    
    //游戏排名的游戏ID
    static let rankingGameID = DefaultsKey<Int?>("rankingGameID") //游戏ID
}
