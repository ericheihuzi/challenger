//
//  RequestDefine.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/2.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation

//与请求相关的定义
// 用户相关
//let RequestHome = "http://localhost:8030"                         //host
let RequestHome = "http://132.232.202.136"                        //host
let RequestUserInfoPath = "/users/getUserInfo"                    //GET-查询用户信息 token
let RequestUserHeadImage = "/users/avatar/"                       //GET-获取头像
let RequestUserInfoUpdate = "/users/updateInfo"                   //POST-更新用户信息
let RequestUserLogin = "/users/login"                             //POST-登录
let RequestUserRegister = "/users/register"                       //POST-注册
let RequestUserExit = "/users/exit"                               //POST-退出登录
let RequestUserChangePassword = "/users/changePassword"           //POST-修改密码

// 挑战相关
let RequestTodayWorldRanking = "/challenges/getTodayWorldRanking" //GET-获取今日世界排名列表
let RequestWorldRanking = "/challenges/getWorldRanking"           //GET-获取世界排名列表
let RequestChallengeInfo = "/challenges/getChallengeInfo"         //GET-获取挑战信息 token
let RequestChallengeLog = "/challenges/getChallengeLog"           //GET-获取挑战记录 token
let RequestGameChallengeLog = "/challenges/getGameChallengeLog"   //GET-获取指定游戏挑战记录 token\gameID
let RequestGradeList = "/challenges/getGradeList"                 //GET-获取段位列表
let RequestChallengeInfoUpdate = "/challenges/updateActorInfo"    //POST-更新挑战信息

// 游戏相关
let RequestGameInfo = "/games/getGameInfo"                        //GET-获取指定游戏信息 gameID
let RequestGameIcon = "/games/icon/"                              //GET-获取游戏图标 + name.jpg
let RequestGameCover = "/games/cover/"                            //GET-获取游戏封面 + name.jpg
let RequestGameList = "/games/getGameList/"                       //GET-获取游戏列表
let RequestUserGameInfo = "/games/getUserGameInfo"                //GET-获取用户指定游戏的信息token\gameID
let RequestGameJoin = "/games/getGameJoin"                        //GET-获取游戏参与人数 gameID
let RequestGameActor = "/games/getGameActor"                      //GET-获取游戏参与者列表 gameID
let RequestGameRanking = "/games/getGameRanking"                  //GET-获取游戏排名列表 gameID
let RequestActorInfoUpdate = "/games/updateActorInfo"             //POST-更新游戏参与者信息

// H5
let RequestUserProtocol = "/h5/userPrivacy"                       //GET-用户协议
let RequestUserPrivacy = "/h5/userProtocol"                       //GET-隐私政策

// H5-Help
let RequestGameHelp = "/help/"                                   //GET-挑战介绍 gameID
