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
    
    //var userInfoUpdate = [String : Any]()
    
    // 获取用户信息状态：0-成功，1-用信息为空，4-token已失效，请重新登录
    var loadStatusValue: Int?
    // 更新用户信息状态：0-成功，4-token已失效，请重新登录
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
            print("loadResult = \(resultDict)")
            
            // 获取status: 0-成功，1-用户信息为空，4-token已失效，请重新登录
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
    func updateUserInfo(_ userInfoUpdate : [String : Any], finishedCallback : @escaping () -> ()) {
        print("要提交的信息 = \(userInfoUpdate)")
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestUserInfoUpdate)", parameters: userInfoUpdate) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            print("updateResult = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            self.updateStatusValue = status
            print("updateStatus = \(status)")
            
            // 获取状态提示语
            guard let message = resultDict["message"] as? String else { return }
            print("updateMessage = \(message)")
            
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
    
    // 上传头像
    // Method: .post
    // Parameters: picName:data(file)
    func updateHeadImage(_ pickedImage: UIImage, finishedCallback : @escaping () -> ()) {
        let parameters: [String : Any] = [
            "token" : Defaults[.token]!
        ]
        NetworkTools.uploadImage(URLString: "\(RequestHome)\(RequestUserInfoUpdate)", parameters: parameters, pickedImage: pickedImage) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            print("uploadResult = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            self.updateStatusValue = status
            print("uploadStatus = \(status)")
            
            // 获取状态提示语
            guard let message = resultDict["message"] as? String else { return }
            print("uploadMessage = \(message)")
            //完成回调
            finishedCallback()
        }
    }
    
}
