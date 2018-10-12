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
    static let isLogin = DefaultsKey<Bool>("isLogin")                           //登录状态
    static let token = DefaultsKey<String?>("token")                            //token
    static let userID = DefaultsKey<String?>("userID")                          //用户ID
    static let account = DefaultsKey<String?>("account")                        //账户
    static let password = DefaultsKey<String?>("password")                      //密码
    
    // 用户信息
    static let nickName = DefaultsKey<String?>("nickName")                      //昵称
    static let phone = DefaultsKey<String?>("phone")                            //手机号
    static let picName = DefaultsKey<String?>("picName")                        //头像名称
    static let picPath = DefaultsKey<String?>("picPath")                        //头像地址
    static let sex = DefaultsKey<Int>("sex")                                    //性别:0未知，1男，2女
    static let birthday = DefaultsKey<String?>("birthday")                      //生日
    static let location = DefaultsKey<String?>("location")                      //地址
    static let age = DefaultsKey<Int>("age")                                    //年龄
    
    //用户挑战信息
    static let challengeTime = DefaultsKey<Int?>("challengeTime")               //挑战次数
    static let rankingChange = DefaultsKey<Int?>("rankingChange")               //今日排名变化
    static let worldRanking = DefaultsKey<Int?>("worldRanking")                 //世界排名
    static let score = DefaultsKey<Int?>("score")                               //用户综合分数
    static let grade = DefaultsKey<String?>("grade")                            //用户段位
    
    static let rewscore = DefaultsKey<Int?>("rewscore")                         //推理力脑力值
    static let cawscore = DefaultsKey<Int?>("cawscore")                         //计算力脑力值
    static let inwscore = DefaultsKey<Int?>("inwscore")                         //视察力脑力值
    static let mewscore = DefaultsKey<Int?>("mewscore")                         //记忆力脑力值
    static let spwscore = DefaultsKey<Int?>("spwscore")                         //空间力脑力值
    static let crwscore = DefaultsKey<Int?>("crwscore")                         //创造力脑力值
        
    //游戏排名的游戏ID
    static let rankingGameID = DefaultsKey<String>("rankingGameID")                //游戏ID
}
