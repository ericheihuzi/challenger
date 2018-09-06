//
//  MainViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/7.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class MainViewModel {
    //lazy var defaultsAccount : [DefaultsAccountModel] = [DefaultsAccountModel]()
    //lazy var userChallengeData : [UserChallengeModel] = [UserChallengeModel]()
    
    //定义字典属性
    var DefaultsAccountDict : [String : Any] = [
        "userID" : Defaults[.userID] ?? "",
        "userPhoneNum" : Defaults[.phone] ?? "",
        //"userPassword" : Defaults[.userPassword] ?? "",
        "userNickName" : Defaults[.nickName] ?? "",
        "userHeadImageURL" : Defaults[.userHeadImageURL] ?? "",
        "userSex" : Defaults[.sex],
        "userBirthday" : Defaults[.birthday] ?? ""
    ]
}

extension MainViewModel {
    func loadUserAccount(finishedCallback : @escaping () -> ()) {
        let userPlist = Bundle.main.path(forResource: "UserAccount", ofType: "plist")
        
        // 1.获取属性列表文件中的全部数据
        guard let userDict = NSDictionary(contentsOfFile: userPlist!)! as? [String : Any] else {return}
        
        DefaultsAccountDict = userDict
        // 2.字典转模型
        print(userDict)
        // 3.完成回调array
        finishedCallback()
    }
}

/*
 extension AllChallengeViewModel {
 func loadAllGameData(finishedCallback : @escaping () -> ()) {
 NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
 // 1.获取到数据
 guard let resultDict = result as? [String : Any] else { return }
 guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
 
 // 2.字典转模型
 for dict in dataArray {
 self.games.append(AllChallengeModel(dict: dict))
 }
 
 // 3.完成回调
 finishedCallback()
 }
 }
 }
 */

