//
//  AddUserInfoValidationService.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/5.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import RxSwift
import SwiftyUserDefaults

//import struct Foundation.CharacterSet
//import struct Foundation.URL
//import struct Foundation.URLRequest
//import struct Foundation.NSRange
//import class Foundation.URLSession
//import func Foundation.arc4random

class AddUserInfoDefaultValidationService: UserInfoValidationService {
    
    func validateNickName(_ nickName: String) -> ValidationResult {
        let accountCharacters = nickName.count
        if accountCharacters > 20 {
            return .failed(message: "昵称不能超过20个字符")
        } else if accountCharacters > 0 && accountCharacters < 6 {
            return .failed(message: "昵称不能少于6个字符")
        }
        
        if nickName.isEmpty {
            return .empty
        }
        
        //昵称可用
        return .ok(message: "")
    }
}
