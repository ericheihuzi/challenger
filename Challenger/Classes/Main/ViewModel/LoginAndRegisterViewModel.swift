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
    var account: String?
    
    // 密码
    var password: String?
    
    // 登录状态：0:成功，22:密码错误，21:用户不存在
    var loginStatusValue: Int?
    // 注册状态：0:成功，20:用户已存在，1:失败，条件不足，无法注册
    var registerStatusValue: Int?
}

extension LoginAndRegisterViewModel {
    // 登录
    // Method: .post
    // Parameters: account: string, password: string
    func login(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestUserLogin)", parameters: ["account" : account!, "password" : password! ]) { (result) in
            
            // 将获取的数据转为字典
            guard let resultDict1 = result as? [String : Any] else { return }
            //print("loginResult = \(resultDict1)")
            
            // 获取状态
            guard let status1 = resultDict1["status"] as? Int else { return }
            print("loginStatus = \(status1)")
            self.loginStatusValue = status1
            
            // 获取状态提示语
            guard let message1 = resultDict1["message"] as? String else { return }
            print("loginMessage = \(message1)")
            
            if self.loginStatusValue == 0 {
                // 获取data:accessToken,userID并转为字典
                guard let dataDict1 = resultDict1["data"] as? [String : Any] else { return }
                print("loginData = \(dataDict1)")
                //将data存入userDefaults
                Defaults[.token] = dataDict1["accessToken"] as? String
            }
            
            //完成回调
            finishedCallback()
        }
    }
    
    // 注册
    // Method: .post
    // Parameters: account: string, password: string
    func register(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestUserRegister)", parameters: ["account" : account!, "password" : password! ]) { (result) in
            
            // 将获取的数据转为字典
            guard let resultDict2 = result as? [String : Any] else { return }
            //print("registerResult = \(resultDict2)")
            
            // 获取状态
            guard let status2 = resultDict2["status"] as? Int else { return }
            print("registerStatus = \(status2)")
            self.registerStatusValue = status2
            
            // 获取状态提示语
            guard let message2 = resultDict2["message"] as? String else { return }
            print("registerMessage = \(message2)")
            
            if self.registerStatusValue == 0 {
                // 获取data:accessToken,userID并转为字典
                guard let dataDict2 = resultDict2["data"] as? [String : Any] else { return }
                print("registerData = \(dataDict2)")
                
                //将data存入userDefaults
                Defaults[.token] = dataDict2["accessToken"] as? String
            }
            
            //完成回调
            finishedCallback()
        }
    }
}
