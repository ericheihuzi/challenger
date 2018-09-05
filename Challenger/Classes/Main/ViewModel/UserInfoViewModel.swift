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
    
    // MARK: 定义模型属性
    var userInfo : UserInfoModel? {
        didSet {
            Defaults[.phone] = userInfo?.phone
            Defaults[.location] = userInfo?.location
            Defaults[.nickName] = userInfo?.nickName
            Defaults[.userHeadImageURL] = userInfo?.pickName
            Defaults[.sex] = userInfo!.sex
            Defaults[.birthday] = userInfo?.birthday
            Defaults[.age] = userInfo!.age
        }
    }
    
    var statusValue: Int = 0
}

extension UserInfoViewModel {
    // MARK: - 通过token获取用户账户信息
    func loadUserInfo(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "\(RequestHome)\(RequestUserInfoPath)" + Defaults[.token]!) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            //print("resultDict = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            self.statusValue = status
            print("status = \(status)")
            
            // 获取状态提示语
            guard let message = resultDict["message"] as? String else { return }
            print("message = \(message)")
            
            if status == 0 {
                guard let accountDict = resultDict["data"] as? [String : Any] else { return }
                print("accountDict = \(accountDict)")
                
                // 字典转模型
                //self.infos.append(UserInfoModel(dict: accountDict))
                
                // 将数据存入模型
                let infoData = UserInfoModel(dict: accountDict)
                // 将模型存入userDefaults
                self.userInfo = infoData
            }
            
            //完成回调
            finishedCallback()
        }
    }
    
}

