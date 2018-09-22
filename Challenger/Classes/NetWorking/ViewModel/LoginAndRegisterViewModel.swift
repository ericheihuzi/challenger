//
//  LoginAndRegisterViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/6.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class LoginAndRegisterViewModel {
    
    // 账号
    //var account: String?
    
    // 密码
    //var password: String?
    
    // 新密码
    //var newPassword: String?
    
    // 登录状态：0-成功，22-密码错误，21-用户不存在
    //var loginStatusValue: Int?
    // 注册状态：0-成功，20-用户已存在，1-失败，条件不足，无法注册
    //var registerStatusValue: Int?
    // 退出登录状态：0-成功
    //var exitStatusValue: Int?
    // 修改密码状态：0-成功
    //var changeStatusValue: Int?
}

extension LoginAndRegisterViewModel {
    // 登录
    // Method: .post
    // Parameters: account: string, password: string
    func login(_ account: String, _ password: String, finishedCallback : @escaping (_ status: Int) -> ()) {
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestUserLogin)", parameters: ["account" : account, "password" : password]) { (result) in
            
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            print("登录结果 = \(resultDict)")
            
            // 获取状态: 0-成功，22-密码错误，21-用户不存在
            guard let status = resultDict["status"] as? Int else { return }
            //print("loginStatus = \(status)")
            //self.loginStatusValue = status
            
            // 获取状态提示语
            //guard let message = resultDict["message"] as? String else { return }
            //print("loginMessage = \(message)")
            //CBToast.showToastAction(message: message as NSString)
            
            if status == 0 {
                // 获取data:accessToken,userID并转为字典
                guard let dataDict = resultDict["data"] as? [String : Any] else { return }
                print("登录数据 = \(dataDict)")
                //将data存入userDefaults
                Defaults[.token] = dataDict["accessToken"] as? String
                Defaults[.userID] = dataDict["userID"] as? String
                Defaults[.account] = account
            }
            
            //完成回调
            finishedCallback(status)
        }
    }
    
    // 注册
    // Method: .post
    // Parameters: account: string, password: string
    func register(_ account: String, _ password: String, finishedCallback : @escaping (_ status: Int) -> ()) {
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestUserRegister)", parameters: ["account" : account, "password" : password]) { (result) in
            
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            print("注册结果 = \(resultDict)")
            
            // 获取状态: 0-成功，20-用户已存在，1-失败，条件不足，无法注册
            guard let status = resultDict["status"] as? Int else { return }
            //print("registerStatus = \(status)")
            //self.registerStatusValue = status
            
            // 获取状态提示语
            //guard let message = resultDict["message"] as? String else { return }
            //print("registerMessage = \(message)")
            
            if status == 0 {
                // 获取data:accessToken,userID并转为字典
                guard let dataDict = resultDict["data"] as? [String : Any] else { return }
                print("注册数据 = \(dataDict)")
                
                //将data存入userDefaults
                Defaults[.token] = dataDict["accessToken"] as? String
                Defaults[.userID] = dataDict["userID"] as? String
            }
            
            //完成回调
            finishedCallback(status)
        }
    }
    
    // 退出登录
    // Method: .post
    // Parameters: token: String
    func loginExit(finishedCallback : @escaping (_ status: Int) -> ()) {
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestUserExit)", parameters: ["token" : Defaults[.token]!]) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            print("退出结果 = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            //print("exitStatus = \(status)")
            //self.exitStatusValue = status
            
            // 获取状态提示语
            //guard let message = resultDict["message"] as? String else { return }
            //print("exitMessage = \(message)")
            //CBToast.showToastAction(message: message as NSString)
            
            //完成回调
            finishedCallback(status)
        }
    }
    
    // 修改密码
    // Method: .post
    // Parameters: account: String, oldPassword: String, newPassword: String
    func changePassword(_ account: String, _ password: String, _ newPassword: String, finishedCallback : @escaping (_ status: Int) -> ()) {
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestUserChangePassword)", parameters: ["account" : account, "password" : password, "newPassword" : newPassword]) { (result) in
            
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            print("修改密码结果 = \(resultDict)")
            
            // 获取状态
            guard let status = resultDict["status"] as? Int else { return }
            //print("changeStatus = \(status)")
            //self.changeStatusValue = status
            
            // 获取状态提示语
            //guard let message = resultDict["message"] as? String else { return }
            //print("changeMessage = \(message)")
            
            //完成回调
            finishedCallback(status)
        }
    }
    
}
