//
//  UserInfoViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/5.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class UserInfoViewModel {
    lazy var infos : [UserInfoModel] = [UserInfoModel]()
    
    var userInfoLoad : UserInfoModel? {
        didSet {
            Defaults[.phone] = userInfoLoad?.phone
            Defaults[.location] = userInfoLoad?.location
            Defaults[.nickName] = userInfoLoad?.nickName
            Defaults[.userHeadImageURL] = userInfoLoad?.picName
            Defaults[.sex] = userInfoLoad!.sex
            Defaults[.birthday] = userInfoLoad?.birthday
            Defaults[.age] = userInfoLoad!.age
        }
    }
    
    var userInfoUpdate = [String : Any]()
    
    // 获取用户信息状态：0:成功，1:用信息为空
    var loadStatusValue: Int?
    // 更新用户信息状态：0:成功，4:token失效，需重新登录
    var updateStatusValue: Int?
}

extension UserInfoViewModel {
    // 获取用户信息
    // Method: .get
    // Parameters: token: string
    func loadUserInfo(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "\(RequestHome)\(RequestUserInfoPath)" + Defaults[.token]!) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            //print("loadUserInfo = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            self.loadStatusValue = status
            print("loadStatus = \(status)")
            
            // 获取状态提示语
            guard let message = resultDict["message"] as? String else { return }
            print("loadMessage = \(message)")
            
            if self.loadStatusValue == 0 {
                guard let accountDict = resultDict["data"] as? [String : Any] else { return }
                print("loadData = \(accountDict)")
                
                // 字典转模型
                //self.infos.append(UserInfoModel(dict: accountDict))
                
                // 将数据存入模型
                let infoData = UserInfoModel(dict: accountDict)
                // 将模型存入userDefaults
                self.userInfoLoad = infoData
                
                Defaults[.isLogin] = true
            } else {
                Defaults[.isLogin] = false
            }
            
            //完成回调
            finishedCallback()
        }
    }
    
    // 修改用户信息
    // Method: .post
    // Parameters: token:string//age:int//sex:int//nickName:string//phone:string
    // birthday:string//location:string//picName:data(file)
    func updateUserInfo(finishedCallback : @escaping () -> ()) {
        print("要提交的信息 = \(userInfoUpdate)")
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestUserInfoUpdate)", parameters: userInfoUpdate) { (result) in
            // 将获取的数据转为字典
            guard let resultDict2 = result as? [String : Any] else { return }
            print("updateUserInfo = \(resultDict2)")
            
            // 获取status
            guard let status2 = resultDict2["status"] as? Int else { return }
            self.updateStatusValue = status2
            print("updateStatus = \(status2)")
            
            // 获取状态提示语
            guard let message2 = resultDict2["message"] as? String else { return }
            print("updateMessage = \(message2)")
            
            //            if self.updateStatusValue == 0 {
            //                // 将数据存入模型
            //                let infoModel = UserInfoModel(dict: userInfoUpdate)
            //                // 将模型存入userDefaults
            //                self.userInfoLoad = infoModel
            //            }
            
            //完成回调
            finishedCallback()
        }
    }
    
}
