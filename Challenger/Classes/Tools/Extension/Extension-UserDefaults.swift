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
    static let infoStatus = DefaultsKey<Int>("infoStatus")                      //获取状态：0成功，1空
    static let nickName = DefaultsKey<String?>("nickName")                      //昵称
    static let phone = DefaultsKey<String?>("phone")                            //手机号
    static let picName = DefaultsKey<String?>("picName")                        //头像名称
    static let picPath = DefaultsKey<String?>("picPath")                        //头像地址
    static let sex = DefaultsKey<Int>("sex")                                    //性别:0未知，1男，2女
    static let birthday = DefaultsKey<String?>("birthday")                      //生日
    static let location = DefaultsKey<String?>("location")                      //地址
    static let age = DefaultsKey<Int>("age")                                    //年龄
    
    //用户游戏信息
    static let challengeNum = DefaultsKey<Int>("challengeNum")                  //挑战次数
    static let rankingChange = DefaultsKey<Int>("rankingChange")                //今日排名变化
    static let userWorldRanking = DefaultsKey<Int>("userWorldRanking")          //世界排名
    static let userScore = DefaultsKey<Int>("userScore")                        //用户综合分数
    static let userGrade = DefaultsKey<String?>("userGrade")                    //用户段位
    
    static let reasoningScore = DefaultsKey<Int>("reasoningScore")      //推理力脑力值
    static let calculationScore = DefaultsKey<Int>("calculationScore")  //计算力脑力值
    static let inspectionScore = DefaultsKey<Int>("inspectionScore")    //视察力脑力值
    static let memoryScore = DefaultsKey<Int>("memoryScore")            //记忆力脑力值
    static let spaceScore = DefaultsKey<Int>("spaceScore")              //空间力脑力值
    static let createScore = DefaultsKey<Int>("createScore")            //创造力脑力值
    
    static let launchCount = DefaultsKey<Int>("launchCount")
    
    //图表属性
    static let chartViewDataColor = DefaultsKey<String?>("chartViewDataColor")  //雷达图主题色
    
    //游戏排名的游戏ID
    static let rankingGameID = DefaultsKey<Int>("rankingGameID")                //游戏ID
}