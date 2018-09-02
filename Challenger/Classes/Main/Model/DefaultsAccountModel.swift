//
//  DefaultsAccountModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/7.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class DefaultsAccountModel {
    //定义模型属性
    var DefaultsAccountDict : [String : Any] = [
        "userID" : Defaults[.userID] ?? "",
        "userPhoneNum" : Defaults[.phone] ?? "",
        "userPassword" : Defaults[.password] ?? "",
        "userNickName" : Defaults[.nickName] ?? "",
        "userHeadImageURL" : Defaults[.userHeadImageURL] ?? "",
        "userSex" : Defaults[.sex],
        "userBirthday" : Defaults[.birthday] ?? ""
    ]
}
