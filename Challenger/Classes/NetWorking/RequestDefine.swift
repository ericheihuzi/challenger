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
let RequestHome = "http://localhost:8008"                //host
//let RequestHome = "http://api.jinxiansen.com"            //host
let RequestUserInfoPath = "/users/getUserInfo?token="    //通过用户Token查询用户信息
let RequestUserInfoUpdate = "/users/updateInfo"          //提交用户信息
let RequestUserLogin = "/users/login"                    //登录
let RequestUserRegister = "/users/register"              //注册
let RequestUserExit = "/users/exit"                      //退出登录
let RequestUserChangePassword = "/users/changePassword"  //修改密码
let RequestUserHeadImage = "/users/avatar/"               //修改密码
