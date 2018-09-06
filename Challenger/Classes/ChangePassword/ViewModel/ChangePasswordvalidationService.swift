//
//  ChangePasswordvalidationService.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/7.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import RxSwift
import SwiftyUserDefaults

class ChangePasswordDefaultValidationService: ChangePasswordValidationService {
    
    let minPasswordCount = 6
    
    // 验证原密码
    func validateOldPassword(_ oldPassword: String) -> ValidationResult {
        let numberOfCharacters = oldPassword.count
        if numberOfCharacters == 0 {
            return .empty
        }
        
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "")
        }
        //密码可用
        return .ok(message: "")
    }
    
    // 验证第一次输入的新密码
    func validateNewPassword(_ newPassword: String) -> ValidationResult {
        let numberOfCharacters = newPassword.count
        if numberOfCharacters == 0 {
            return .empty
        }
        
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "密码最少需要 \(minPasswordCount) 个字符")
        }
        //密码可用
        return .ok(message: "")
    }
    
    // 验证第二次输入的新密码
    func validateRepeatedNewPassword(_ newPassword: String, _ repeatedNewPassword: String) -> ValidationResult {
        if repeatedNewPassword.count == 0 {
            return .empty
        }
        
        if repeatedNewPassword == newPassword {
            // 密码重复
            return .ok(message: "输入正确")
        }
        else {
            return .failed(message: "两次输入的密码不相同")
        }
    }
}

