//
//  SignUpValidationService.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/26.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import RxSwift
import SwiftyUserDefaults

class SignUpDefaultValidationService: SignUpValidationService {
    
    let minPasswordCount = 6
    
    // 验证账号
    func validateAccount(_ account: String) -> ValidationResult {
        let accountCharacters = account.count
        if accountCharacters > 20 {
            return .failed(message: "账号不能超过20个字符")
        } else if accountCharacters > 0 && accountCharacters < 10 {
            return .failed(message: "账号不能少于10个字符")
        }
        
        if account.isEmpty {
            return .empty
        }
        
        // this obviously won't be
        if account.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .failed(message: "账号只能包含字母和数字")
        }
        
        //账号可用
        return .ok(message: "")
    }
    
    // 验证第一次输入的密码
    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        if numberOfCharacters == 0 {
            return .empty
        }
        
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "密码最少需要 \(minPasswordCount) 个字符")
        }
        //密码可用
        return .ok(message: "")
    }
    
    // 验证第二次输入的密码
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult {
        if repeatedPassword.count == 0 {
            return .empty
        }
        
        if repeatedPassword == password {
            // 密码重复
            return .ok(message: "输入正确")
        }
        else {
            return .failed(message: "两次输入的密码不相同")
        }
    }
}
