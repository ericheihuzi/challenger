//
//  RequestDefine.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/2.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation

let LoginUserInfoKey = "LoginUserInfoKey"       //归档用户信息使用的key
let loginTokenKey = "key" //尚未实现，此Demo的二次登录先记录Password来实现

//与请求相关的定义
// 用户相关
let RequestHome = "http://localhost:8030"                         //host
//let RequestHome = "http://api.jinxiansen.com"                     //host
let RequestUserInfoPath = "/users/getUserInfo"                    //GET查询用户信息 token
let RequestUserInfoUpdate = "/users/updateInfo"                   //POST更新用户信息
let RequestUserLogin = "/users/login"                             //POST登录
let RequestUserRegister = "/users/register"                       //POST注册
let RequestUserExit = "/users/exit"                               //POST退出登录
let RequestUserChangePassword = "/users/changePassword"           //修改密码
let RequestUserHeadImage = "/users/avatar/"                       //获取头像

// 挑战相关
let RequestChallengeInfo = "/challenges/getChallengeInfo"              //获取挑战信息 token
let RequestChallengeInfoUpdate = "/challenges/updateChallengeInfo"     //更新挑战信息
let RequestChallengeLog = "/challenges/getChallengeLog"                //获取挑战记录 token
let RequestGameChallengeLog = "/challenges/getGameChallengeLog"        //获取指定游戏挑战记录 token\gameID

// 游戏相关
let RequestGameInfo = "/games/getGameInfo"                        //获取指定游戏信息 gameID
let RequestGameIcon = "/games/icon/"                              //获取游戏图标 + name.jpg
let RequestGameCover = "/games/cover/"                            //获取游戏封面 + name.jpg
let RequestGameList = "/games/getGameList/"                       //获取游戏列表
let RequestUserGameInfo = "/games/getUserGameInfo"                //获取用户指定游戏的信息token\gameID
let RequestUserGameInfoUpdate = "/games/updateUserGameInfo"       //更新用户指定游戏的信息
let RequestGameJoin = "/games/getGameJoin"                        //获取游戏列表 gameID

// H5
let RequestUserProtocol = "/h5/userPrivacy"                       //用户协议
let RequestUserPrivacy = "/h5/userProtocol"                       //隐私政策
