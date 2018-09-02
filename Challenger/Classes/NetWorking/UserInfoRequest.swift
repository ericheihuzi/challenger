//
//  UserInfoRequest.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/2.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

/// 用户相关的接口请求
class UserInfoRequest: BaseRequest {
    
    /// 通过用户token查询用户信息
    ///
    /// - Parameter token: 用户token
    func queryUserInfo(token: String){
        
        //1.拼接请求路径
        let requestPath = "\(RequestHome)\(RequestUserInfoPath)"
        
        //2.实现闭包回调
        let request = Request(start: {
            self.start()
        }, success: { (json) in
            guard let userInfos = json as? [String: Any] else {
                return
            }
            
            let userModel: UserModel = UserModel()
            if userInfos["list"] != nil {
                guard let userInfo = userInfos["list"]! as? [String:String] else {
                    return
                }
                userModel.userId = userInfo["userId"] ?? ""
                userModel.account = userInfo["account"] ?? ""
            }
            self.success(userModel)
            
        }) { (errorMessage) in
            self.faile(errorMessage)
        }
        
        let params: [String:String] = ["token": token]
        request.getRequest(path: "\(requestPath)", parameters: params)
    }
    
    
    /// 登录网络请求
    ///
    /// - Parameters:
    ///   - account: 用户名
    ///   - password: 密码
    func login(account: String, password: String){
        loginOrRegister(requestPath: "\(RequestHome)\(RequestUserLogin)", account: account, password: password)
    }
    
    
    /// 注册网络请求
    ///
    /// - Parameters:
    ///   - account: 用户名
    ///   - password: 密码
    func register(account: String, password: String){
        loginOrRegister(requestPath: "\(RequestHome)\(RequestUserRegister)", account: account, password: password)
    }
    
    
    
    /// 登录或者注册调用的公共部分，统一处理登录或者注册成功的事件
    ///
    /// - Parameters:
    ///   - requestPath: 请求路径
    ///   - account: 用户名
    ///   - password: 密码
    func loginOrRegister(requestPath: String, account: String, password: String) {
        let request = Request(start: {
            self.start()
        }, success: { (json) in
            guard let userInfos = json as? [String: Any] else {
                return
            }
            
            let userModel: UserModel = UserModel()
            
            if userInfos["list"] != nil {
                guard let userInfo = userInfos["list"]! as? [String:String] else {
                    return
                }
                
                userModel.userId = userInfo["userId"] ?? ""
                userModel.account = userInfo["account"] ?? ""
                userModel.regestTime = userInfo["registerTime"] ?? ""
            }
            
            //将用户信息存入单例
            //AccountManager.share().userId = userModel.userId
            //AccountManager.share().account = userModel.account
            //AccountManager.share().regestTime = userModel.regestTime
            
            //将用户信息单例归档存入UserDefault中，便于二次登录使用
            //self.recoderUserInfo()
            self.success(userModel)
            
        }) { (errorMessage) in
            self.faile(errorMessage)
        }
        let params: [String:String] = ["account": account, "password": password]
        request.postRequest(path: "\(requestPath)", parameters: params)
    }
    
    /*
    /// 将用户信息单例归档存入UserDefault中，便于二次登录使用
    func recoderUserInfo() {
        let data = NSKeyedArchiver.archivedData(withRootObject: AccountManager.share())
        UserDefaults.standard.setValue(data, forKey: LoginUserInfoKey)
    }
    */
    
    /// 退出登录，清空归档信息
    static func loginOut() {
        Defaults.removeAll()
        //UserDefaults.standard.removeObject(forKey: LoginUserInfoKey)
    }
}
